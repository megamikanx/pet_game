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
	Water= Water,
	Burger = Burger,
	DollarBill = Money,
	Squishy = Squishy,
	EnergyDrink = EnergyDrink,
	ProteinBar = ProteinBar
}

@onready var stageInfo: Resource
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
