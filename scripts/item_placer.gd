extends Node

var current_item_script = load("res://scripts/item_scripts/speakerItem.gd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	var instance
	"""if event.is_action_pressed("LMB"):
		instance = Global.ITEM_SCENE.instantiate()
		instance.set_script(current_item_script)
		instance.position = event.position
		add_child(instance)"""
	pass
