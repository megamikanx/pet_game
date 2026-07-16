@abstract class_name Item
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@abstract func _on_body_entered(body: Node2D) -> void

func _on_body_exited(body: Node2D) -> void:
	pass
