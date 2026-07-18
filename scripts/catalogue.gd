extends Control

@onready var pattern: TextureRect = $Background/Pattern
var start_x
var start_y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_x = pattern.position.x
	start_y = pattern.position.y

func _move_tiles():
	pattern.position.x -= 0.3
	pattern.position.y -= 0.3
	
	if (pattern.position.x == start_x - 170):
		pattern.position.x = start_x
		pattern.position.y = start_y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move_tiles()
	
func _on_back_button_pressed() -> void:
	AudioManager.play_click()
	if Global.previous_scene != "":
		get_tree().change_scene_to_file(Global.previous_scene)
