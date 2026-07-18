class_name Money
extends Item

const PREFERENCE: String = "Money"

func get_preference() -> String:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
		animate_pet(pet, "something")
	else:
		pass
	pass
