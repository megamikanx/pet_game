class_name DollarBill
extends Item

const PREFERENCE: String = "DollarBill"
var SPRITE = load("res://sprites/item_sprites/Money.png")

func get_sprite() -> Texture2D:
	return SPRITE

func _on_body_entered(body: Node2D) -> void:
	if body is Pet:
		body.move_preference(global_position, PREFERENCE)
	pass

func _on_body_exited(body: Node2D) -> void:
	if body is Pet:
		body.rand_walk = true
	pass
