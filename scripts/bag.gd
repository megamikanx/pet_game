extends Node2D

@onready var slot1: Slot = $Slot1
@onready var slot2: Slot = $Slot2
@onready var slot3: Slot = $Slot3
@onready var slot4: Slot = $Slot4
@onready var slot5: Slot = $Slot5

@onready var itemSpawner:  = $ItemSpawner

signal hold_item

var items: Array[Item] = [Beer.new(),Squishy.new(),Beer.new(),Beer.new(),Beer.new()]
var held_item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var slots: Array[Area2D] = [slot1, slot2, slot3, slot4, slot5]
	
	for i in range(slots.size()):
		slots[i].input_event.connect(slot_grab.bind(slots[i]))
		slots[i].mouse_entered.connect(darken.bind(slots[i]))
		slots[i].mouse_exited.connect(undarken.bind(slots[i]))
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
