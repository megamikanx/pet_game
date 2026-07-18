@abstract class_name Item
extends Area2D

@onready var sprite = $ItemSprite

var added_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	monitoring = false
	pass

@abstract func cause_afflication(pet: Pet, doesLike: bool) -> void
@abstract func get_preference() -> String

func place() -> void:
	monitorable = true
	monitoring = true
	pass

func setup() -> void:
	sprite.texture = get_sprite()

func get_sprite() -> Texture2D:
	return ItemInfo.ITEM.get(get_preference()).get("SPRITE")

func get_pri() -> int:
	return ItemInfo.ITEM.get(get_preference()).get("PRIORITY")

func _on_body_entered(body: Node2D) -> void:
	if body is Pet:
		body.add_afflication(self)
	pass

func _on_body_exited(body: Node2D) -> void:
	if body is Pet:
		body.remove_afflication(self)
	pass



#interaction methods
func add_pet_sprite(pet: Pet, texture: Texture2D) -> void:
	added_sprite = pet.add_sprite(texture)
	
func remove_pet_sprite(pet: Pet) -> void:
	if added_sprite != null:
		added_sprite.queue_free()
	added_sprite = null
	
func scale_pet(pet: Pet, scale: float) -> void:
	pet.scale = scale * Vector2.ONE
	
func change_speed(pet: Pet, speed: int) -> void:
	pet.SPEED += speed

func start_bouncing(pet: Pet) -> void:
	pet.start_bouncing()

func move_pet(pet: Pet, goal: Vector2) -> void:
	pet.set_goal(goal)

func run(pet: Pet) -> void:
	pet.set_goal(self.position.direction_to(pet.position) * 1000)

func stop_running(pet: Pet) -> void:
	pet.restart_walking()

func animate_pet(pet: Pet, animation) -> void:
	pass
