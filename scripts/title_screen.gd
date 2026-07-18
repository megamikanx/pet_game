extends Control

func _ready() -> void:
	pass

func _on_play_button_pressed() -> void:
	AudioManager.play_click()
	if Global.has_seen_comic:
		get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/story/motion_comic.tscn")
