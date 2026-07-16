extends Node

@onready var PET_SCENE = preload("res://scenes/pet_scene.tscn")
@onready var ITEM_SCENE = preload("res://scenes/item_scene.tscn")

var current_stage: int = 1
var highest_unlocked: int = 1
var cleared_stages: Array[int] = []
var has_seen_comic: bool = false

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
