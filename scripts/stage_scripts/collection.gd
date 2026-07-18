extends Area2D


@onready var submitButton = $SubmitButton
@onready var petSpawner = get_parent().get_node("Spawner")

signal hold_pet

var collected_pet: Pet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	submitButton.visible = false
	set_process(false)
	set_process_input(false)
	
	submitButton.pressed.connect(check_answer)
	body_entered.connect(collect_held_pet)
	body_exited.connect(uncollect_held_pet)
	pass

#ID of answer always 0
func check_answer() -> void:
	print(collected_pet.get_ID())
	if collected_pet.get_ID() == 0:
		print("found")
		# once stage cleared mark down and move on to next
		var pet_tex: Texture2D = StageLoadedInfo.get_petTexture()
		var pet_name: String = ""
		Global.add_captured_pet(Global.current_stage, pet_tex, pet_name)
		Global.clear_stage(Global.current_stage)
		get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
	else:
		print("wrong pet")
	pass

func place_pet(pet: Pet) -> void:
	collected_pet = pet
	pet.set_global_position.call_deferred(position)
	submitButton.visible = true
	set_process_input(true)

func collected_pickedup(pet : Pet) -> void:
	collected_pet = null
	submitButton.visible = false

func collect_held_pet(body: Node2D) -> void:
	if body is Pet:
		body.collected = true

func uncollect_held_pet(body: Node2D) -> void:
	if body is Pet:
		body.collected = false
		
