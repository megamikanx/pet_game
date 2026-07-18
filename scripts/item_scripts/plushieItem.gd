class_name Plushie
extends Item

const PREFERENCE: String = "Plushie"

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, position)
	else:
		pass
	pass
