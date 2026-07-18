class_name Flower
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.Flower

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		pass
	else:
		run(pet)
	pass
