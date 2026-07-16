extends Control

@onready var stage_label: Label = $StageLabel
@onready var bubble: Panel = $Bubble
@onready var continue_button: Button = $ContinueButton
@onready var trait_icon: TextureRect = $Bubble/TraitIcon
@onready var client_portrait: TextureRect = $ClientPortrait

var portrait_closed: Texture2D = preload("res://sprites/character_sprites/miku1.png")
var portrait_open: Texture2D = preload("res://sprites/character_sprites/miku2.png")

var is_talking: bool = false


var trait_icons: Array[Texture2D] = [
	preload("res://sprites/trait1.png"),
	preload("res://sprites/trait2.png"),
	preload("res://sprites/trait3.png"),
]

var trait_index: int = 0

var portrait_rest_pos: Vector2

func _show_current_trait() -> void:
	trait_icon.texture = trait_icons[trait_index]
	
func _play_talk_animation() -> void:
	for _i in range(3):
		client_portrait.texture = portrait_open
		client_portrait.position = portrait_rest_pos + Vector2(0, -4)  # up
		await get_tree().create_timer(0.08).timeout
		client_portrait.texture = portrait_closed
		client_portrait.position = portrait_rest_pos + Vector2(0, 3)   # down a bit
		await get_tree().create_timer(0.08).timeout
	client_portrait.texture = portrait_closed
	client_portrait.position = portrait_rest_pos
	
func _ready() -> void:
	stage_label.text = "Clue Stage %d" % Global.current_stage
	client_portrait.texture = portrait_closed
	bubble.visible = true
	continue_button.visible = false
	trait_index = 0
	_show_current_trait()
	client_portrait.texture = portrait_closed
	portrait_rest_pos = client_portrait.position

func _on_advance_button_pressed() -> void:
	if is_talking:
		return
	is_talking = true
	await _play_talk_animation()
	is_talking = false
	trait_index += 1
	if trait_index >= trait_icons.size():
		bubble.visible = false
		continue_button.visible = true
	else:
		_show_current_trait()

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stages/packing_stage.tscn")
	
