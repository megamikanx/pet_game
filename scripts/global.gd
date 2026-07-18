extends Node

@onready var GameStats: Resource = preload("res://scripts/info_scripts/GameStats.tres")

@onready var PET_SCENE = preload("res://scenes/pet_scene.tscn")
@onready var ITEM_SCENE = preload("res://scenes/item_scene.tscn")

var current_stage: int = 1
var highest_unlocked: int = 1
var cleared_stages: Array[int] = []
var has_seen_comic: bool = false
var captured_pets: Array[Dictionary] = []
var previous_scene: String = ""

var petScale: float = 0.25

var stage_data: Dictionary[int, Dictionary]

func _ready() -> void:
	for stage in StageLoadedInfo.STAGES:
		stage_data[stage.stageNum] = {
		"client_name": stage.clientName,
		"portrait_closed": stage.clientTalkClose,
		"portrait_open": stage.clientTalkOpen,
		"label": stage.clientNameTag,
		"nametag": stage.petNameTag,
		"hint": stage.packingHint,
		"dialogue": stage.clientDialogue,
		"required_items": ["Plushie"], # only thing that doesn't work really
		"wrong_line": stage.clientWrongLine,
		"success_line": stage.clientSuccessLine,
	}
	print(stage_data)


"""
var stage_data: Dictionary = {
	1: {
		"client_name": "Miku",
		"portrait_closed": preload(
			"res://sprites/miku_talk_close.png"
		),
		"portrait_open": preload(
			"res://sprites/miku_talk_open.png"
		),
		"label": preload(
			"res://sprites/miku_nametag.png"
		),
		"nametag": preload(
			"res://sprites/pibbles_nametag.png"
		),
		"hint": preload(
			"res://sprites/miku_hints.png"
		),
		"dialogue": [
			preload("res://sprites/miku_talk_1.png"),
			preload("res://sprites/miku_talk_2.png"),
			preload("res://sprites/miku_talk_3.png"),
			preload("res://sprites/miku_talk_4.png"),
			preload("res://sprites/miku_talk_5.png"),
			preload("res://sprites/miku_talk_6.png"),
		],
		"required_items": ["Plushie"],
		"wrong_line": preload("res://sprites/miku_level_wrong.png"),
		"success_line": preload("res://sprites/miku_level_right.png"),
	},
	2: {
		"client_name": "Sonic",
		"portrait_closed": preload(
			"res://sprites/sonic_talk_close.png"
		),
		"portrait_open": preload(
			"res://sprites/sonic_talk_open.png"
		),
		"label": preload(
			"res://sprites/sonic_nametag.png"
		),
		"nametag": preload(
			"res://sprites/gooba_nametag.png"
		),
		"hint": preload(
			"res://sprites/sonic_hints.png"
		),
		"dialogue": [
			preload("res://sprites/sonic_talk_1.png"),
			preload("res://sprites/sonic_talk_2.png"),
			preload("res://sprites/sonic_talk_3.png"),
			preload("res://sprites/sonic_talk_4.png"),
			preload("res://sprites/sonic_talk_5.png"),
			preload("res://sprites/sonic_talk_6.png"),
			preload("res://sprites/sonic_talk_7.png"),
			preload("res://sprites/sonic_talk_8.png"),
			preload("res://sprites/sonic_talk_9.png"),
		],
		"required_items": ["TopHat", "Water"],
		"wrong_line": preload("res://sprites/sonic_level_wrong.png"),
		"success_line": preload("res://sprites/sonic_level_right.png"),
	},
	3: {
		"client_name": "Kris",
		"portrait_closed": preload(
			"res://sprites/kris_talk_close.png"
		),
		"portrait_open": preload(
			"res://sprites/kris_talk_open.png"
		),
		"label": preload(
			"res://sprites/kris_nametag.png"
		),
		"nametag": preload(
			"res://sprites/bingus_nametag.png"
		),
		"hint": preload(
			"res://sprites/kris_hints.png"
		),
		"dialogue": [
			preload("res://sprites/kris_talk_1.png"),
			preload("res://sprites/kris_talk_2.png"),
			preload("res://sprites/kris_talk_3.png"),
			preload("res://sprites/kris_talk_4.png"),
			preload("res://sprites/kris_talk_5.png"),
			preload("res://sprites/kris_talk_6.png"),
			preload("res://sprites/kris_talk_7.png"),
			preload("res://sprites/kris_talk_8.png"),
			preload("res://sprites/kris_talk_9.png"),
			preload("res://sprites/kris_talk_10.png"),
		],
		"required_items": ["Speaker", "BucketSlop", "Flower", "DollarBill"],
		"wrong_line": preload("res://sprites/kris_level_wrong.png"),
		"success_line": preload("res://sprites/kris_level_right.png"),
	},
	4: {
		"client_name": "Joker",
		"portrait_closed": preload(
			"res://sprites/joker_talk_close.png"
		),
		"portrait_open": preload(
			"res://sprites/joker_talk_open.png"
		),
		"label": preload(
			"res://sprites/joker_nametag.png"
		),
		"nametag": preload(
			"res://sprites/healseal_nametag.png"
		),
		"hint": preload(
			"res://sprites/joker_hints.png"
		),
		"dialogue": [
			preload("res://sprites/joker_talk_1.png"),
			preload("res://sprites/joker_talk_2.png"),
			preload("res://sprites/joker_talk_3.png"),
			preload("res://sprites/joker_talk_4.png"),
			preload("res://sprites/joker_talk_5.png"),
			preload("res://sprites/joker_talk_6.png"),
			preload("res://sprites/joker_talk_7.png"),
			preload("res://sprites/joker_talk_8.png"),
			preload("res://sprites/joker_talk_9.png"),
			preload("res://sprites/joker_talk_10.png"),
			preload("res://sprites/joker_talk_11.png"),
		],
		"required_items": ["Bath", "Burger", "Beer", "Squishy"],
		"wrong_line": preload("res://sprites/joker_level_wrong.png"),
		"success_line": preload("res://sprites/joker_level_right.png"),
	},
	5: {
		"client_name": "Isaac",
		"portrait_closed": preload(
			"res://sprites/isaac_talk_close.png"
		),
		"portrait_open": preload(
			"res://sprites/isaac_talk_open.png"
		),
		"label": preload(
			"res://sprites/isaac_nametag.png"
		),
		"nametag": preload(
			"res://sprites/pyungus_nametag.png"
		),
		"hint": preload(
			"res://sprites/isaac_hints.png"
		),
		"dialogue": [
			preload("res://sprites/isaac_talk_1.png"),
			preload("res://sprites/isaac_talk_2.png"),
			preload("res://sprites/isaac_talk_3.png"),
			preload("res://sprites/isaac_talk_4.png"),
			preload("res://sprites/isaac_talk_5.png"),
			preload("res://sprites/isaac_talk_6.png"),
			preload("res://sprites/isaac_talk_7.png"),
			preload("res://sprites/isaac_talk_8.png"),
			preload("res://sprites/isaac_talk_9.png"),
			preload("res://sprites/isaac_talk_10.png"),
			preload("res://sprites/isaac_talk_11.png"),
		],
		"required_items": ["Bath", "ProteinBar", "Beer", "Plushie", "TopHat"],
		"wrong_line": preload("res://sprites/isaac_level_wrong.png"),
		"success_line": preload("res://sprites/isaac_level_right.png"),
	},
}
"""
func get_current_stage_data() -> Dictionary:
	return stage_data[current_stage]
	
func exit_game() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		exit_game()
		
func is_stage_unlocked(stage: int) -> bool:
	return stage <= highest_unlocked

func is_stage_cleared(stage: int) -> bool:
	return stage in cleared_stages

func clear_stage(stage: int) -> void:
	if stage not in cleared_stages:
		cleared_stages.append(stage)
	if stage >= highest_unlocked and highest_unlocked < 5:
		highest_unlocked = stage + 1
