@abstract class_name Item
extends Area2D

@onready var sprite = $ItemSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	monitoring = false
	pass

func setup() -> void:
	sprite.texture = get_sprite()

@abstract func _on_body_entered(body: Node2D) -> void
@abstract func get_sprite() -> Texture2D

func _on_body_exited(body: Node2D) -> void:
	pass

func placed() -> void:
	monitoring = true
