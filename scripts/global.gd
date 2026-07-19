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

#cheap so dont have to do work
var penTopLeftBorder: Vector2
var penBotRightBorder: Vector2

var petScale: float = 0.5

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

func add_captured_pet(stage: int, pet_texture: Texture2D, pet_name: String = "") -> void:
	for entry in captured_pets:
		if entry["stage"] == stage:
			return
	captured_pets.append({
		"stage": stage,
		"texture": pet_texture,
		"name": pet_name,
	})
