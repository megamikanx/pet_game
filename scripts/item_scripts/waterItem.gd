class_name Water
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.Water
var SPRITE_TO_ADD = load("res://sprites/pet_sprites/scope.png")

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE
	
func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, position)
	else:
		add_pet_sprite(pet, SPRITE_TO_ADD)
	pass
