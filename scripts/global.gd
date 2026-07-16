extends Node


func exit_game() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		exit_game()
