class_name Speaker
extends Item

const PREFERENCE: String = "Speaker"
var SPRITE = load("res://sprites/item_sprites/Beer.png")

func get_pri() -> int:
	return ItemInfo.ITEM_PRIORITY.get(PREFERENCE)

func get_preference() -> String:
	return PREFERENCE

func get_sprite() -> Texture2D:
	return SPRITE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
	else:
		run(pet)
	pass
