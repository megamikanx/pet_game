class_name Info_Stage
extends Resource



@export var stageNum = 1
@export var NUM_PETS = 10
@export var petTexture: Texture2D = preload("res://sprites/pet_sprites/pibbles.png")

@export var answer_personality: Array[ItemInfo.ITEM_TYPE]
@export var valid_preferences: Array[ItemInfo.ITEM_TYPE]
