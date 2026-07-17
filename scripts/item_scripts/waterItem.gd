class_name Water
extends Item

const PREFERENCE: String = "Water"
var SPRITE = load("res://sprites/item_sprites/water.png")

var SPRITE_TO_ADD = load("res://sprites/pet_sprites/scope.png")

func get_pri() -> int:
	return ItemInfo.ITEM_PRIORITY.get(PREFERENCE)

func get_preference() -> String:
	return PREFERENCE

func get_sprite() -> Texture2D:
	return SPRITE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, position)
	else:
		add_pet_sprite(pet, SPRITE_TO_ADD)
	pass
