extends Node2D

const OFFSET = 135

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var VIEWSIZE = get_viewport().get_visible_rect().size
	var ROWS = 6
	var COLS = 5
	var scene = preload("res://scenes/duplicate.tscn")
	var instance
	for x in ROWS:
		for y in COLS:
			instance = scene.instantiate()
			instance.position = Vector2(randi_range(64, VIEWSIZE.x-64),
										randi_range(64, VIEWSIZE.y-64))
			add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	var scene = preload("res://scenes/itemScene.tscn")
	var instance
	if (event is InputEventMouseButton && event.is_pressed() && event.button_index == 2):
		instance = scene.instantiate()
		instance.set_script(load("res://scripts/Items/speakerItem.gd"))
		instance.position = event.position
		add_child(instance)
	pass
