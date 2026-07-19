extends Node2D

@onready var slots: Array[Area2D] = [$Slot1, $Slot2, $Slot3, $Slot4, $Slot5]
@onready var itemSpawner = $ItemSpawner

@onready var collections = get_parent().get_node("Collection")

signal hold_item

var items: Array[Item] = []
var held_item

var MAX_USES = Global.GameStats.MaxItemUsages

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
	if event.is_action_pressed("LMB") and slot.get_uses() < MAX_USES and collections.collected_pet == null:
		hold_item.emit(itemSpawner.spawn(slot))
	pass

func darken(slot: Slot) -> void:
	slot.darken()
	slot.raise()

func undarken(slot: Slot) -> void:
	slot.undarken()
	slot.unraise()
