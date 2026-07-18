class_name Chocolate
extends Item

const PREFERENCE: String = "Chocolate"

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, position)
	else:
		pass
	pass
