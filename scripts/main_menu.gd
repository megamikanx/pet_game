extends Control
func _on_title_screen_pressed() -> void:
	AudioManager.play_click()
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _on_level_select_pressed() -> void:
	AudioManager.play_click()
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
	
func _on_catalogue_pressed() -> void:
	AudioManager.play_click()
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/catalogue.tscn")
	
func _on_quit_pressed() -> void:
	AudioManager.play_click()
	get_tree().quit()
	
func _on_menu_button_pressed() -> void:
	AudioManager.play_click()
	if Global.previous_scene != "":
		get_tree().change_scene_to_file(Global.previous_scene)
