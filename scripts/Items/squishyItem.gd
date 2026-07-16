extends Item

const PREFERENCE: String = "Squishy"

func _on_body_entered(body: Node2D) -> void:
	if body is Pet:
		body.move_preference(global_position, PREFERENCE)
	pass

func _on_body_exited(body: Node2D) -> void:
	if body is Pet:
		body.rand_walk = true
	pass
