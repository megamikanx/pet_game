class_name Info_Stage
extends Resource



@export var stageNum = 1
@export var NUM_PETS = 10
@export var levelTexture: Texture2D
@export var petTexture: Texture2D

@export var clientName: String
@export var clientNameTag: Texture2D

@export var clientTalkClose: Texture2D
@export var clientTalkOpen: Texture2D

@export var clientDialogue: Array[Texture2D]

@export var clientWrongLine: Texture2D
@export var clientSuccessLine: Texture2D

@export var answer_personality: Dictionary[ItemInfo.ITEM_TYPE, bool]
@export var valid_preferences: Array[ItemInfo.ITEM_TYPE]
