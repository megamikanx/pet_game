extends Node

@onready var NAMES: Dictionary = {
	Beer = Beer,
	Bath = Bath,
	Water= Water,
	Burger = Burger,
	DollarBill = Money,
	Squishy = Squishy,
	EnergyDrink = EnergyDrink,
	ProteinBar = ProteinBar
}

@onready var stageInfo: Resource = Info_Stage1.new()
@onready var itemsHotbar: Array[Item]

#SETTERS

func set_stage(stage: Resource) -> void:
	stageInfo = stage

func set_items(items: Array[Node]) -> void:
	itemsHotbar = []
	for entry in items:
		itemsHotbar.append(NAMES[entry.name].new())
	pass

#GETTERS

func get_hotbar() -> Array[Item]:
	return itemsHotbar

func get_numPets() -> int:
	return stageInfo.NUM_PETS

func get_petTexture() -> Texture2D:
	return stageInfo.petTexture
