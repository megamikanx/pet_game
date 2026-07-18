extends Node


@onready var STAGES: Array[Resource] = [
	preload("res://scripts/stageinfo_scripts/stageinfo1.tres"),
	preload("res://scripts/stageinfo_scripts/stageinfo2.tres"),
	preload("res://scripts/stageinfo_scripts/stageinfo3.tres"),
	preload("res://scripts/stageinfo_scripts/stageinfo4.tres"),
	preload("res://scripts/stageinfo_scripts/stageinfo5.tres")
]

@onready var NAMES: Dictionary = {
	Beer = Beer,
	Bath = Bath,
	Water = Water,
	Burger = Burger,
	Money = Money,
	DollarBill = Money,
	Squishy = Squishy,
	EnergyDrink = EnergyDrink,
	ProteinBar = ProteinBar,
	BucketSlop = BucketOfSlop,
	Carcass = DeadCarcass,
	Flower = Flower,
	Plushie = Plushie,
	TopHat = TopHat,
}

@onready var stageInfo: Resource = STAGES[0]
@onready var itemsHotbar: Array[Item]

# Setters
func set_stage(stage: Resource) -> void:
	stageInfo = stage

func set_items(items: Array[Node]) -> void:
	itemsHotbar = []
	for entry in items:
		if not NAMES.has(entry.name):
			push_error("No mapping for packed item: " + entry.name)
			continue
		itemsHotbar.append(NAMES[entry.name].new())


# getters
func get_hotbar() -> Array[Item]:
	return itemsHotbar

func get_numPets() -> int:
	return stageInfo.NUM_PETS

func get_petTexture() -> Texture2D:
	return stageInfo.petTexture

func get_answer_personality() -> Dictionary[ItemInfo.ITEM_TYPE, bool]:
	return stageInfo.answer_personality

func get_valid_preferences() -> Array[ItemInfo.ITEM_TYPE]:
	print(stageInfo.valid_preferences.size())
	if stageInfo.valid_preferences.size() > 0:
		return stageInfo.valid_preferences
	
	var valid: Array[ItemInfo.ITEM_TYPE]
	for item in ItemInfo.ITEM_TYPE.values():
		valid.append(item)

	return valid
