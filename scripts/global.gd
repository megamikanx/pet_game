extends Node

@onready var PET_SCENE = preload("res://scenes/pet_scene.tscn")
@onready var ITEM_SCENE = preload("res://scenes/item_scene.tscn")

func exit_game() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		exit_game()
