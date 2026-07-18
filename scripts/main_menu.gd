extends Control
func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
	
func _on_catalogue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/catalogue.tscn")
	
func _on_quit_pressed() -> void:
	get_tree().quit()
