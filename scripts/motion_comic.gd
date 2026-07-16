extends Control

func _on_continue_pressed() -> void:
	Global.current_stage = 1
	get_tree().change_scene_to_file("res://scenes/stages/clue_stage.tscn")
