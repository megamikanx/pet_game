extends Control

@onready var desk_area: Control = $DeskArea
@onready var bag_bar: HBoxContainer = $BagPanel/BagBar

var items: Array[Dictionary] = []

func _ready() -> void:
	await get_tree().process_frame  # wait one frame so positions are real
	var buttons: Array[Button] = [
		$DeskArea/SampleItem,
		$DeskArea/SampleItem2,
		$DeskArea/SampleItem3,
		$DeskArea/SampleItem4,
	]
	for button in buttons:
		var entry: Dictionary = {
			"button": button,
			"desk_global_pos": button.global_position,
			"desk_size": button.size,   # NEW — remember original size
			"is_packed": false,
		}
		print(button.name, " home=", entry["desk_global_pos"])
		items.append(entry)
		button.pressed.connect(_on_item_pressed.bind(entry))

func _on_item_pressed(entry: Dictionary) -> void:
	print("Clicked: ", entry["button"].name, " packed=", entry["is_packed"])
	if entry["is_packed"]:
		await _unpack_item(entry)
	else:
		_pack_item(entry)

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
