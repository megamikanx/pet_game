class_name Burger
extends Item

const PREFERENCE: String = "Burger"

var CHANGED_SPEED = -10

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		change_speed(pet, CHANGED_SPEED)
	else:
		pass
	pass
