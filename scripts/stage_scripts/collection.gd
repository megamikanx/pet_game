extends Area2D


@onready var submitButton = $SubmitButton
@onready var petSpawner = get_parent().get_node("Spawner")
@onready var instructionsSprite = get_parent().get_node("Instructions")
@onready var responseSprite = $response

signal hold_pet
signal wrong_guess

var collected_pet: Pet
var ended = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	submitButton.visible = false
	set_process(false)
	set_process_input(false)
	
	responseSprite.visible = false
	instructionsSprite.visible = true
	ended = false
	
	submitButton.pressed.connect(check_answer)
	body_entered.connect(collect_held_pet)
	body_exited.connect(uncollect_held_pet)
	pass

#ID of answer always 0
func check_answer() -> void:
	print(collected_pet.get_ID())
	responseSprite.visible = true
	
	if get_parent().health == 0 or ended:
		return
	
	if collected_pet.get_ID() == 0:
		print("found")
		AudioManager.play_correct()
		# once stage cleared mark down and move on to next
		var pet_tex: Texture2D = StageLoadedInfo.get_petTexture()
		var pet_name: String = ""
		Global.add_captured_pet(Global.current_stage, pet_tex, pet_name)
		Global.clear_stage(Global.current_stage)
		
		responseSprite.texture = StageLoadedInfo.get_successLine()
		ended = true
		await get_tree().create_timer(2).timeout
		
		get_tree().change_scene_to_file("res://scenes/stages/stage_select.tscn")
	else:
		print("wrong pet")
		AudioManager.play_incorrect()
		responseSprite.texture = StageLoadedInfo.get_wrongLine()
		wrong_guess.emit()
		await get_tree().create_timer(3).timeout
		responseSprite.visible = false
	pass

func place_pet(pet: Pet) -> void:
	collected_pet = pet
	pet.set_global_position.call_deferred(position)
	submitButton.visible = true
	instructionsSprite.visible = false
	set_process_input(true)

func collected_pickedup(pet : Pet) -> void:
	collected_pet = null
	submitButton.visible = false
	instructionsSprite.visible = true

func collect_held_pet(body: Node2D) -> void:
	if body is Pet:
		body.collected = true

func uncollect_held_pet(body: Node2D) -> void:
	if body is Pet:
		body.collected = false
		
