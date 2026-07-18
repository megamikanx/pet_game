class_name Beer
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.Beer
var ADD_PROPS = ItemInfo.ADD_SPRITES.get(get_preference())

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE


func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
		add_pet_sprite(pet, ADD_PROPS.get("SPRITE"), ADD_PROPS.get("DIM"))
	else:
		run(pet)
