class_name Burger
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.Burger

var CHANGED_SPEED = -10

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		change_speed(pet, CHANGED_SPEED)
	else:
		pass
	pass
