class_name Flower
extends Item

const PREFERENCE: String = "Flower"
var SPRITE = ItemInfo.ITEM_SPRITE.get(PREFERENCE)

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
	pass
