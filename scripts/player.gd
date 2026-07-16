extends CharacterBody2D


const SPEED = 300.0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED

func _physics_process(_delta: float) -> void:
	get_input()
	#dup()
	move_and_slide()

func dup() -> void:
	var scene = preload("res://scenes/duplicate.tscn")
	var instance = scene.instantiate()
	instance.global_position = global_position
	add_child(instance)
	
	print(global_position)
	
	
