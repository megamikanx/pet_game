class_name Spawner
extends Node2D

const OFFSET = 64
const NUM = 30

signal hold_pet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lower_sx = 421 + OFFSET
	var upper_sx = 941 - OFFSET
	var lower_sy = 78 + OFFSET
	var upper_sy = 598 - OFFSET
	
	var instance
	for i in NUM:
		instance = Global.PET_SCENE.instantiate()
		instance.freeze_pets.connect(freeze_pets)
		instance.position = Vector2(randi_range(lower_sx, upper_sx),
									randi_range(lower_sy, upper_sy))
		
		add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func freeze_pets(the_holded : Pet) -> void:
	hold_pet.emit(the_holded)
	for pet in get_children():
		pet.freeze()

func unfreeze_pets(the_holded : Pet) -> void:
	for pet in get_children():
		pet.unfreeze.call_deferred()
