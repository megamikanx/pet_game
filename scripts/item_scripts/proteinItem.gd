class_name ProteinBar
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.ProteinBar

const SCALE = 1.5

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		scale_pet(pet, SCALE)
	else:
		pass
	pass
