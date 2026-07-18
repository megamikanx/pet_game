class_name Squishy
extends Item

const PREFERENCE: String = "Squishy"

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
		start_bouncing(pet)
	else:
		pass
	pass
