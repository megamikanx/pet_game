extends Control

@onready var desk_area: Control = $DeskArea
@onready var bag_bar: HBoxContainer = $BagPanel/BagBar
@onready var item_tooltip: TextureRect = $ItemToolTip

var items: Array[Dictionary] = []
const MAX_PACKED_ITEMS: int = 5

func _ready() -> void:
	await get_tree().process_frame  # wait one frame so positions are real

	var buttons: Array[Dictionary] = [
		{
			"button": $DeskArea/Beer,
			"tooltip": preload("res://sprites/beer_text.png"),
		},
		{
			"button": $DeskArea/Bath,
			"tooltip": preload("res://sprites/bath_text.png"),
		},
		{
			"button": $DeskArea/Water,
			"tooltip": preload("res://sprites/water_text.png"),
		},
		{
			"button": $DeskArea/Burger,
			"tooltip": preload("res://sprites/burger_text.png"),
		},
		{
			"button": $DeskArea/DollarBill,
			"tooltip": preload("res://sprites/dollar_text.png"),
		},
		{
			"button": $DeskArea/Squishy,
			"tooltip": preload("res://sprites/squishy_text.png"),
		},
		{
			"button": $DeskArea/EnergyDrink,
			"tooltip": preload("res://sprites/energydrink_text.png"),
		},
		{
			"button": $DeskArea/ProteinBar,
			"tooltip": preload("res://sprites/proteinbar_text.png"),
		},
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
func _on_item_mouse_exited() -> void:
	item_tooltip.visible = false
	
func _get_packed_item_count() -> int:
	var packed_count: int = 0
	for entry in items:
		if entry["is_packed"]:
			packed_count += 1
	return packed_count
	
func _on_item_pressed(entry: Dictionary) -> void:
	if entry["is_packed"]:
		await _unpack_item(entry)
	elif _get_packed_item_count() >= MAX_PACKED_ITEMS:
		print("The bag is full!")
		return
	else:
		_pack_item(entry)

func _on_go_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/spawning.tscn")

func _pack_item(entry: Dictionary) -> void:
	var button: Button = entry["button"]
	entry["is_packed"] = true
	button.reparent(bag_bar)
	button.expand_icon = true
	button.modulate = Color.WHITE
	button.custom_minimum_size = entry["desk_size"]
	button.size = entry["desk_size"]
	button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	button.size_flags_vertical = Control.SIZE_SHRINK_CENTER

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
	
