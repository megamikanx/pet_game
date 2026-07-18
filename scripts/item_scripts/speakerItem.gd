class_name Speaker
extends Item

const PREFERENCE: String = "Speaker"

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
	else:
		run(pet)
	pass
