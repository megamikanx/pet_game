class_name ProteinBar
extends Item

const PREFERENCE: String = "ProteinBar"
var SPRITE = load("res://sprites/item_sprites/protein bar.png")

const SCALE = 1.5

func get_pri() -> int:
	return ItemInfo.ITEM_PRIORITY.get(PREFERENCE)

func get_preference() -> String:
	return PREFERENCE

func get_sprite() -> Texture2D:
	return SPRITE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		scale_pet(pet, SCALE)
	else:
		pass
	pass
