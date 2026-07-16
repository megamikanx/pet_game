class_name Pet
extends RigidBody2D

@onready var petSprite = $petSprite
@onready var flagSprite = petSprite.get_node("flagSprite")
@onready var animationSprite = petSprite.get_node("animation")
@onready var aniPlayer = petSprite.get_node("AnimationPlayer")
@onready var timer = $Timer

@onready var selectArea = $SelectionArea

signal freeze_pets

var border_topY: float = 78
var border_botY: float = 598
var border_lefX: float = 421
var border_rigX: float = 941

@onready var OFFSET = petSprite.texture.get_size().x/2

const SPEED = 50
const MIN_RAND_GOAL_DIST = 75
const MAX_RAND_GOAL_DIST = 100

const PALETTE: Array[Color] = [
	Color.WHITE,
	Color.GREEN,
	Color.MEDIUM_PURPLE,
	Color.ORANGE,
	Color.DEEP_SKY_BLUE
]

const PREF_REACTION: Dictionary = {
	Chocolate = ["run", "run"],
	Speaker = ["animate", "run"],
	Plushie = ["run", "ignore"],
	BucketOfSlop = ["run", "run"],
	DeadCarcass = ["run", "run"],
	Flower = ["ignore", "run"],
	TopHat = ["animate", "ignore"],
	Beer = ["animate", "run"],
	DollarBill = ["animate", "ignore"],
	Water = ["run", "animate"],
	Squishy = ["animate", "ignore"]
}

var ANIMATION: Dictionary = {
	Speaker = "animation",
	TopHat = "animation",
	Beer = "animation",
	DollarBill = "animation",
	Water = "animation",
	Squishy = "animation"
}

var personality: Dictionary = {
	Chocolate = false,
	Speaker = false,
	Plushie = false,
	BucketOfSlop = false,
	DeadCarcass = false,
	Flower = false,
	TopHat = false,
	Beer = false,
	DollarBill = false,
	Water = false,
	Squishy = false
}

var rand_walk: bool = true
var goal: Vector2
var dragging: bool = false
var predrag_position: Vector2

# Intialise the Pet
func _ready() -> void:
	randomGoal()
	petSprite.self_modulate = PALETTE.pick_random()
	flagSprite.visible = false
	timer.wait_time = randf_range(0.5, 1.5)
	set_process_input(false)
	
	timer.timeout.connect(timeout_rand_walk)
	selectArea.input_event.connect(input_selection_area)
	
	for like in personality.keys():
		personality[like] = bool(randi_range(0,1))
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !dragging:
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

# Changes pets goal everynow and then
func timeout_rand_walk() -> void:
	randomGoal()
	timer.wait_time = randf_range(0.5, 1.5)
	pass


func input_selection_area(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if dragging and event.is_action_pressed("LMB"):
		freeze_pets.emit(self)
		return
	
	if event.is_action_pressed("RMB"):
		flagSprite.visible = not flagSprite.visible
	elif event.is_action_pressed("LMB"):
		start_drag()
	pass

func start_drag() -> void:
	predrag_position = position
	linear_velocity = Vector2.ZERO
	set_collision_mask_value(1, false)
	rand_walk = false
	
	freeze_pets.emit(self)

func stop_drag() -> void:
	position = predrag_position
	rand_walk = true
	set_collision_mask_value(1, true)

func freeze() -> void:
	set_process(false)
	dragging = true
	linear_velocity = Vector2.ZERO

func unfreeze() -> void:
	set_process(true)
	dragging = false
	linear_velocity = Vector2.ZERO




func move_preference(new_pos: Vector2, preference: String) -> void:
	if personality.get(preference):
		positive_reaction(new_pos, preference)
	else:
		negative_reaction(new_pos, preference)
	pass


func positive_reaction(new_pos: Vector2, preference: String) -> void:
	match PREF_REACTION.get(preference)[0]:
		"run":
			rand_walk = false
			goal = new_pos
			pass
		"ignore":
			pass
		"animate":
			rand_walk = false
			goal = position
			aniPlayer.current_animation = ANIMATION.get(preference)
			pass
	pass
func negative_reaction(new_pos: Vector2, preference: String) -> void:
	match PREF_REACTION.get(preference)[1]:
		"run":
			rand_walk = false
			goal = position + 1000 * new_pos.direction_to(position)
			pass
		"ignore":
			pass
		"animate":
			rand_walk = false
			goal = position
			aniPlayer.current_animation = ANIMATION.get(preference)
			pass
	pass
