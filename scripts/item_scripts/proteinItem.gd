class_name ProteinBar
extends Item

const PREFERENCE: String = "ProteinBar"

const SCALE = 1.5

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		scale_pet(pet, SCALE)
	else:
		pass
	pass
