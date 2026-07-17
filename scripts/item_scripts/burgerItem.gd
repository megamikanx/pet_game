class_name Burger
extends Item

const PREFERENCE: String = "Burger"
var SPRITE = load("res://sprites/item_sprites/burger.png")

var CHANGED_SPEED = -10

func get_pri() -> int:
	return ItemInfo.ITEM_PRIORITY.get(PREFERENCE)

func get_preference() -> String:
	return PREFERENCE

func get_sprite() -> Texture2D:
	return SPRITE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		change_speed(pet, CHANGED_SPEED)
	else:
		pass
	pass
