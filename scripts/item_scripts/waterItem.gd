class_name Water
extends Item

const PREFERENCE: String = "Water"
var SPRITE_TO_ADD = load("res://sprites/pet_sprites/scope.png")

func get_preference() -> String:
	return PREFERENCE
	
func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, position)
	else:
		add_pet_sprite(pet, SPRITE_TO_ADD)
	pass
