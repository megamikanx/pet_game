extends Node

@onready var PET_SCENE = preload("res://scenes/pet_scene.tscn")
@onready var ITEM_SCENE = preload("res://scenes/item_scene.tscn")

var current_stage: int = 1
var highest_unlocked: int = 1
var cleared_stages: Array[int] = []
var has_seen_comic: bool = false

var stage_data: Dictionary = {
	1: {
		"client_name": "Miku",
		"bag_limit": 1,
		"portrait_closed": preload(
			"res://sprites/miku_talk_close.png"
		),
		"portrait_open": preload(
			"res://sprites/miku_talk_open.png"
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
		"wrong_line": "Miku needs you to lock in.",
		"success_line": "San-Kyu!",
	},
}

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
