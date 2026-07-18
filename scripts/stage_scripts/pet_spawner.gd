class_name Spawner
extends Node2D

const OFFSET = 64

signal hold_pet

@onready var collection = get_parent().get_node("Collection")

func spawn_pets(num : int, texture: Texture2D) -> void:
	var offsetX = texture.get_size().x * 0.5 * Global.petScale
	var offsetY = texture.get_size().y * 0.5 * Global.petScale

	var lower_sx = 421 + offsetX
	var upper_sx = 941 - offsetX
	var lower_sy = 78 + offsetY
	var upper_sy = 598 - offsetY
	
	var instance: Pet
	for i in num:
		instance = Global.PET_SCENE.instantiate()
		instance.pick_me_up.connect(pet_picked_up)
		instance.pick_me_up.connect(collection.collected_pickedup)
		instance.freeze_pets.connect(freeze_pets)
		instance.unfreeze_pets.connect(unfreeze_pets)
		instance.send_coll.connect(collection.place_pet)
		
		add_child(instance)
		
		instance.position = Vector2(randi_range(lower_sx, upper_sx),
									randi_range(lower_sy, upper_sy))
		instance.set_petTexture(texture)
		instance.set_ID(i)
	pass

func pet_picked_up(the_holded : Pet) -> void:
	hold_pet.emit(the_holded)

func freeze_pets() -> void:
	for pet in get_children():
		pet.freeze()

func unfreeze_pets() -> void:
	for pet in get_children():
		pet.unfreeze.call_deferred()
