class_name Beer
extends Item

const PREFERENCE: String = "Beer"
var SPRITE = load("res://sprites/item_sprites/Beer.png")
var SPRITE_TO_ADD = load("res://sprites/pet_sprites/scope.png")

func get_pri() -> int:
	return ItemInfo.ITEM_PRIORITY.get(PREFERENCE)

func get_preference() -> String:
	return PREFERENCE

func get_sprite() -> Texture2D:
	return SPRITE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
		add_pet_sprite(pet, SPRITE_TO_ADD)
	else:
		run(pet)
