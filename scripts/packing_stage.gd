extends Control

@onready var desk_area: Control = $DeskArea
@onready var item_tooltip: TextureRect = $ItemToolTip
@onready var slots: Array[Control] = [
	$BagPanel/BagBar/Slot1,
	$BagPanel/BagBar/Slot2,
	$BagPanel/BagBar/Slot3,
	$BagPanel/BagBar/Slot4,
	$BagPanel/BagBar/Slot5,
]

@onready var NAMES: Dictionary = {
	Beer = Beer,
	Bath = Bath,
	Water = Water,
	Burger = Burger,
	Money = Money,
	Squishy = Squishy,
	EnergyDrink = EnergyDrink,
	ProteinBar = ProteinBar,
	BucketSlop = BucketOfSlop,
	Carcass = DeadCarcass,
	Flower = Flower,
	Plushie = Plushie,
	TopHat = TopHat,
	# Yakult = Yakult,
}

@onready var pet_nametag: TextureRect = $PetNameTag
@onready var clue_sheet: TextureRect = $ClueSheet

const SLOT_ITEM_SIZE := Vector2(100, 100)

var items: Array[Dictionary] = []
var max_packed_items: int = 5


func _ready() -> void:
	Background.set_background("packing")
	
	var stage_data: Dictionary = Global.get_current_stage_data()
	max_packed_items = int(stage_data.get("bag_limit", 5))
	max_packed_items = mini(max_packed_items, slots.size())
	pet_nametag.texture = stage_data["nametag"]
	clue_sheet.texture = stage_data["hint"]

	await get_tree().process_frame

	var buttons: Array[Dictionary] = [
		{"button": $DeskArea/Beer, "tooltip": preload("res://sprites/beer_text.png")},
		{"button": $DeskArea/Bath, "tooltip": preload("res://sprites/bath_text.png")},
		{"button": $DeskArea/Water, "tooltip": preload("res://sprites/water_text.png")},
		{"button": $DeskArea/Burger, "tooltip": preload("res://sprites/burger_text.png")},
		{"button": $DeskArea/Money, "tooltip": preload("res://sprites/dollar_text.png")},
		{"button": $DeskArea/Squishy, "tooltip": preload("res://sprites/squishy_text.png")},
		{"button": $DeskArea/EnergyDrink, "tooltip": preload("res://sprites/energydrink_text.png")},
		{"button": $DeskArea/ProteinBar, "tooltip": preload("res://sprites/proteinbar_text.png")},
		{"button": $DeskArea/BucketSlop, "tooltip": preload("res://sprites/bucketslop_text.png")},
		{"button": $DeskArea/Carcass, "tooltip": preload("res://sprites/carcass_text.png")},
		{"button": $DeskArea/Flower, "tooltip": preload("res://sprites/flower_text.png")},
		{"button": $DeskArea/Plushie, "tooltip": preload("res://sprites/plushie_text.png")},
		{"button": $DeskArea/TopHat, "tooltip": preload("res://sprites/tophat_text.png")},
		{"button": $DeskArea/Yakult, "tooltip": preload("res://sprites/yakult_text.png")},
		{"button": $DeskArea/Speaker, "tooltip": preload("res://sprites/speaker_text.png")},
	]

	for data in buttons:
		var button: Button = data["button"]
		var entry: Dictionary = {
			"button": button,
			"desk_global_pos": button.global_position,
			"desk_size": button.size,
			"is_packed": false,
			"tooltip": data["tooltip"],
		}
		items.append(entry)
		button.pressed.connect(_on_item_pressed.bind(entry))
		button.mouse_entered.connect(_on_item_mouse_entered.bind(entry))
		button.mouse_exited.connect(_on_item_mouse_exited)


func _on_item_mouse_entered(entry: Dictionary) -> void:
	var button: Button = entry["button"]
	item_tooltip.texture = entry["tooltip"]
	item_tooltip.size = Vector2(220, 140)
	var overlap: float = 50.0
	item_tooltip.global_position = Vector2(
		button.global_position.x + (button.size.x - item_tooltip.size.x) / 2.0,
		button.global_position.y - item_tooltip.size.y + overlap
	)
	item_tooltip.visible = true

func _on_menu_button_pressed() -> void:
	AudioManager.play_click()
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_item_mouse_exited() -> void:
	item_tooltip.visible = false


func _get_packed_item_count() -> int:
	var packed_count: int = 0
	for entry in items:
		if entry["is_packed"]:
			packed_count += 1
	return packed_count


func _get_first_empty_slot() -> Control:
	for slot in slots:
		var has_item := false
		for child in slot.get_children():
			if child is Button:
				has_item = true
				break
		if not has_item:
			return slot
	return null


func _get_packed_buttons() -> Array[Node]:
	var packed: Array[Node] = []
	for slot in slots:
		for child in slot.get_children():
			if child is Button:
				packed.append(child)
	return packed


func _on_item_pressed(entry: Dictionary) -> void:
	AudioManager.play_boop()
	if entry["is_packed"]:
		await _unpack_item(entry)
	elif _get_packed_item_count() >= max_packed_items:
		print("The bag is full! Limit: ", max_packed_items)
		return
	else:
		_pack_item(entry)


func _on_go_pressed() -> void:
	AudioManager.play_click()
	var packed := _get_packed_buttons()
	if packed.size() != max_packed_items:
		print("Need exactly ", max_packed_items, " items. Have ", packed.size())
		return

	StageLoadedInfo.set_items(packed)
	Global.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/spawning.tscn")


func _pack_item(entry: Dictionary) -> void:
	var button: Button = entry["button"]
	var slot: Control = _get_first_empty_slot()
	if slot == null:
		print("The bag is full!")
		return

	entry["is_packed"] = true
	button.reparent(slot)
	button.expand_icon = true
	button.modulate = Color.WHITE
	button.set_anchors_preset(Control.PRESET_TOP_LEFT)
	button.custom_minimum_size = SLOT_ITEM_SIZE
	button.size = SLOT_ITEM_SIZE
	button.position = (slot.size - button.size) * 0.5


func _unpack_item(entry: Dictionary) -> void:
	var button: Button = entry["button"]
	entry["is_packed"] = false

	button.reparent(desk_area)
	button.modulate = Color.WHITE
	button.expand_icon = true
	button.custom_minimum_size = entry["desk_size"]
	button.size = entry["desk_size"]
	button.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	button.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	button.set_anchors_preset(Control.PRESET_TOP_LEFT)
	button.global_position = entry["desk_global_pos"]

	await get_tree().process_frame
	button.global_position = entry["desk_global_pos"]
	button.size = entry["desk_size"]
