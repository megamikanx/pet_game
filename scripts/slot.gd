class_name Slot
extends Area2D

@onready var colorRect = $ColorRect
@onready var itemSprite = $ItemSprite

var storedItem: Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorRect.visible = false
	pass # Replace with function body.

func assignItem(assItem: Item) -> void:
	storedItem = assItem
	itemSprite.texture = assItem.get_sprite()

func darken() -> void:
	colorRect.visible = true
	
func undarken() -> void:
	colorRect.visible = false
