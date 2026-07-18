class_name Beer
extends Item

const PREFERENCE: ItemInfo.ITEM_TYPE = ItemInfo.ITEM_TYPE.Beer
var SPRITE_TO_ADD = load("res://sprites/pet_sprites/scope.png")

func get_preference() -> ItemInfo.ITEM_TYPE:
	return PREFERENCE


func cause_afflication(pet: Pet, doesLike: bool) -> void:
	if doesLike:
		move_pet(pet, pet.position)
		add_pet_sprite(pet, SPRITE_TO_ADD)
	else:
		run(pet)
