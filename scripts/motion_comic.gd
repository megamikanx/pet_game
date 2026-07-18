extends Control

@onready var info_1: TextureRect = $Panel/info_1
@onready var info_2: TextureRect = $Panel/info_2

@onready var pattern: TextureRect = $Background/Pattern
var start_x
var start_y

var page:=0

func _ready() -> void:
	info_1.visible = true
	info_2.visible = false
	start_x = pattern.position.x
	start_y = pattern.position.y
	
func _move_tiles():
	pattern.position.x -= 0.3
	pattern.position.y -= 0.3
	
	if (pattern.position.x == start_x - 170):
		pattern.position.x = start_x
		pattern.position.y = start_y
	
func _process(delta: float) -> void:
	_move_tiles()
	
func _on_continue_pressed() -> void:
	AudioManager.play_click()
	if page == 0:
		info_1.visible = false
		info_2.visible = true
		page = 1
	else: 
		Global.current_stage = 1
		Global.has_seen_comic = true
		get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
