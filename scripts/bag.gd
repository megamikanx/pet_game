extends Node2D

@onready var slots: Array[Area2D] = [$Slot1, $Slot2, $Slot3, $Slot4, $Slot5]
@onready var itemSpawner:  = $ItemSpawner

signal hold_item

var items: Array[Item] = [Beer.new(),Squishy.new(),Beer.new(),Beer.new(),Beer.new()]
var held_item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for slot in slots:
		slot.input_event.connect(slot_grab.bind(slot))
		slot.mouse_entered.connect(darken.bind(slot))
		slot.mouse_exited.connect(undarken.bind(slot))
	pass


func set_bag(new_bag: Array[Item]):
	items = new_bag
	for i in range(slots.size()):
		slots[i].assignItem(items[i])
	pass

func slot_grab(viewport: Node, event: InputEvent, shape_idx: int, slot: Slot) -> void:
	if event.is_action_pressed("LMB"):
		hold_item.emit(itemSpawner.spawn(slot))
	pass

func darken(slot: Slot) -> void:
	slot.darken()

func undarken(slot: Slot) -> void:
	slot.undarken()
