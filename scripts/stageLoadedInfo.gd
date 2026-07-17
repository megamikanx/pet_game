extends Node

@onready var NAMES: Dictionary = {
	BeerItem = Beer,
	BathItem = Bath,
	WaterItem = Water,
	BurgerItem = Burger,
	MoneyItem = Money,
	SquishyItem = Squishy,
	MonsterItem = EnergyDrink,
	ProteinItem = ProteinBar
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


#GETTERS

func get_hotbar() -> Array[Item]:
	return itemsHotbar

func get_numPets() -> int:
	return stageInfo.NUM_PETS

func get_petTexture() -> Texture2D:
	return stageInfo.petTexture
