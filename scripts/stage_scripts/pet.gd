class_name Pet
extends RigidBody2D

const PALETTE: Array[Color] = [
	Color.WHITE,
	Color.GREEN,
	Color.MEDIUM_PURPLE,
	Color.ORANGE,
	Color.DEEP_SKY_BLUE
]

const MIN_RAND_GOAL_DIST = 75
const MAX_RAND_GOAL_DIST = 100

signal pick_me_up
signal freeze_pets
signal unfreeze_pets
signal send_coll

var border_topY: float = 78
var border_botY: float = 598
var border_lefX: float = 421
var border_rigX: float = 941

@onready var petSprite = $petSprite
@onready var flagSprite = $petSprite/flagSprite
@onready var animationSprite = $petSprite/animation
@onready var aniPlayer = $petSprite/AnimationPlayer
@onready var timer = $Timer

@onready var selectArea = $SelectionArea

var OFFSET = petSprite.texture.get_size().x * 0.5 * Global.petScale

#Pet variables
var SPEED = 50

var personality: Array[String] = []
var afflication: Array[Item]

var rand_walk: bool = true
var goal: Vector2
var frozen: bool = false
var predrag_position: Vector2
var collected: bool = false

# Intialise the Pet
func _ready() -> void:
	randomGoal()
	flagSprite.visible = false
	timer.wait_time = randf_range(0.5, 1.5)
	set_process_input(false)
	
	timer.timeout.connect(timeout_rand_walk)
	selectArea.input_event.connect(input_selection_area)
	
	pass

func set_petTexture(new_text: Texture2D) -> void:
	petSprite.texture = new_text
	petSprite.self_modulate = PALETTE.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !frozen:
		walk(delta)
	pass

# Walks toward goal location, stops if close enough too it
func walk(delta: float) -> void:
	if position.distance_to(goal) < 5:
		linear_velocity = Vector2.ZERO
		return

	linear_velocity = position.direction_to(goal) * SPEED
	return

func randomGoal() -> void:
	if !rand_walk:
		return

	# chooses from ring around pet for new goal location
	var angle = randf_range(0, 2*PI)
	var distance = randf_range(MIN_RAND_GOAL_DIST, MAX_RAND_GOAL_DIST)
	goal.x = clamp(position.x + distance * cos(angle),
		border_lefX + OFFSET, border_rigX - OFFSET)
	goal.y = clamp(position.y + distance * -sin(angle),
		border_topY + OFFSET, border_botY - OFFSET)
	
	pass

func set_goal(new_goal: Vector2) -> void:
	rand_walk = false
	goal = new_goal

func restart_walking() -> void:
	rand_walk = true
	randomGoal()

# Changes pets goal every now and then
func timeout_rand_walk() -> void:
	randomGoal()
	timer.wait_time = randf_range(0.5, 1.5)
	pass

#Freezing
func freeze() -> void:
	set_process(false)
	frozen = true
	linear_velocity = Vector2.ZERO

func unfreeze() -> void:
	set_process(true)
	frozen = false
	linear_velocity = Vector2.ZERO

#PICKING UP

func input_selection_area(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if frozen:
		if collected and event.is_action_pressed("LMB"):
			pick_me_up.emit(self)
		return
	
	if event.is_action_pressed("RMB"):
		flagSprite.visible = not flagSprite.visible
	elif event.is_action_pressed("LMB"):
		picked_up()
	pass

func picked_up() -> void:
	set_collision_mask_value(1, false)
	set_collision_layer_value(1, false)
	predrag_position = position
	linear_velocity = Vector2.ZERO
	
	freeze_pets.emit()
	pick_me_up.emit(self)

func place() -> void:
	if collected:
		send_coll.emit(self)
	else:
		return_to_pen()

func return_to_pen() -> void:
	set_position.call_deferred(predrag_position)
	set_collision_mask_value(1, true)
	set_collision_layer_value(1, true)
	unfreeze_pets.emit()


# Afflictions

func add_sprite(new_texture: Texture2D) -> Sprite2D:
	var instance = Sprite2D.new()
	petSprite.add_child(instance)
	
	instance.texture = new_texture
	return instance

func update_afflications() -> void:
	restart_walking()
	for aff in afflication:
		aff.cause_afflication(self, aff.get_preference() in personality)
	

func add_afflication(new_item: Item) -> void:
	afflication.append(new_item)
	#sort by priority
	var paired = afflication.map(func(a): return {"pri": a.get_pri(), "key": a})
	paired.sort_custom(func(a,b): return a["pri"] < b["pri"])
	afflication.assign(paired.map(func(p): return p["key"]))
	
	update_afflications()
	pass

func remove_afflication(r_item: Item) -> void:
	afflication.erase(r_item)
	update_afflications()
	pass
