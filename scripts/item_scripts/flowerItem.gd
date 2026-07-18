class_name Flower
extends Item

const PREFERENCE: String = "Flower"

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		pass
	else:
		run(pet)
	pass
