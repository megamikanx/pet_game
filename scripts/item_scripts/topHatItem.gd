class_name TopHat
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.TopHat
var SPRITE_TO_ADD = load("res://sprites/pet_sprites/scope.png")

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE

func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		add_pet_sprite(pet, SPRITE_TO_ADD)
	else:
		pass
	pass
