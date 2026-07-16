extends Control

func _on_continue_pressed() -> void:
	Global.current_stage = 1
	Global.has_seen_comic = true
	get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
