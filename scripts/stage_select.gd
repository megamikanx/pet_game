extends Control

@onready var stage_buttons: Array[Button] = [
	$StageRow/StageButton1,
	$StageRow/StageButton2,
	$StageRow/StageButton3,
	$StageRow/StageButton4,
	$StageRow/StageButton5,
]

@onready var pattern: TextureRect = $Background/Pattern
var start_x
var start_y

func _ready() -> void:
	_refresh_stage_buttons()
	start_x = pattern.position.x
	start_y = pattern.position.y
	for i in stage_buttons.size():
		var stage_num: int = i + 1
		stage_buttons[i].pressed.connect(_on_stage_pressed.bind(stage_num))

func _refresh_stage_buttons() -> void:
	for i in stage_buttons.size():
		var stage_num: int = i + 1
		var button: Button = stage_buttons[i]
		var unlocked: bool = Global.is_stage_unlocked(stage_num)
		var cleared: bool = Global.is_stage_cleared(stage_num)

		button.disabled = not unlocked

		var overlay: ColorRect = button.get_node_or_null("LockOverlay")
		if overlay:
			overlay.visible = not unlocked

		var check: CanvasItem = button.get_node_or_null("CheckMark")
		if check:
			check.visible = cleared

func _on_stage_pressed(stage_num: int) -> void:
	AudioManager.play_click()
	if not Global.is_stage_unlocked(stage_num):
		return
	Global.current_stage = stage_num
	StageLoadedInfo.set_stage(StageLoadedInfo.STAGES[Global.current_stage - 1])

	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/stages/clue_stage.tscn")
	
func _on_menu_button_pressed() -> void:
	AudioManager.play_click()
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_catalogue_button_pressed() -> void:
	AudioManager.play_click()
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/catalogue.tscn")

func _move_tiles():
	pattern.position.x -= 0.3
	pattern.position.y -= 0.3
	
	if (pattern.position.x == start_x - 170):
		pattern.position.x = start_x
		pattern.position.y = start_y
	
func _process(delta: float) -> void:
	_move_tiles()
	
