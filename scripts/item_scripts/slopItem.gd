class_name BucketOfSlop
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.BucketOfSlop

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE
func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, global_position)
	else:
		run(pet)
	pass
