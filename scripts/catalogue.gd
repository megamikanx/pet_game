extends Control

@onready var pattern: TextureRect = $Background/Pattern

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Background.set_background("catalogue")
	pass
	
func _on_back_button_pressed() -> void:
	AudioManager.play_click()
	if Global.previous_scene != "":
		get_tree().change_scene_to_file(Global.previous_scene)
