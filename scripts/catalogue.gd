extends Control

@onready var petSprite = $Pet
@onready var petFloor = $PetContainer/TextureRect
@onready var nameSprite = $PetName

@onready var left = $Left
@onready var right = $Right

var current_screen:int
var max_screen:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Background.set_background("catalogue")
	current_screen = 1
	max_screen = Global.highest_unlocked
	
	
	left.pressed.connect(left_clicked)
	right.pressed.connect(right_clicked)
	
	load_catalogue_screen()
	pass
	
func _on_back_button_pressed() -> void:
	AudioManager.play_click()
	if Global.previous_scene != "":
		get_tree().change_scene_to_file(Global.previous_scene)

func load_catalogue_screen() -> void:
	if current_screen < max_screen:
		petSprite.texture = StageLoadedInfo.STAGES[current_screen - 1].petTexture
		nameSprite.texture = StageLoadedInfo.STAGES[current_screen - 1].petNameTag
	petFloor.texture = StageLoadedInfo.STAGES[current_screen - 1].floorTexture
	
	logic_left_right_appearance()

func left_clicked() -> void:
	current_screen -= 1
	load_catalogue_screen()
	
func right_clicked() -> void:
	current_screen += 1
	load_catalogue_screen()

func logic_left_right_appearance() -> void:
	if current_screen == 1:
		left.disabled = true
		left.visible = false
	else:
		left.disabled = false
		left.visible = true
		
	if current_screen >= max_screen - 1:
		right.disabled = true
		right.visible = false
	else:
		right.disabled = false
		right.visible = true
	pass
