class_name Bath
extends Item

const PREFERENCE: String = "Bath"
var SPRITE = load("res://sprites/item_sprites/bath.png")

func get_pri() -> int:
	return ItemInfo.ITEM_PRIORITY.get(PREFERENCE)

func get_preference() -> String:
	return PREFERENCE

func get_sprite() -> Texture2D:
	return SPRITE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		pass
	else:
		run(pet)
