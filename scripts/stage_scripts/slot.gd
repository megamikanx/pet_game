class_name Slot
extends Area2D

@onready var colorRect = $ColorRect
@onready var itemSprite = $ItemSprite

var storedItem: Item
var uses: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorRect.visible = false
	itemSprite.global_position.y = 639
	itemSprite.scale = 0.7 * Vector2.ONE
	pass # Replace with function body.

func assignItem(assItem: Item) -> void:
	storedItem = assItem
	itemSprite.texture = assItem.get_sprite()

func darken() -> void:
	colorRect.visible = true
	
func undarken() -> void:
	colorRect.visible = false

func get_uses() -> int:
	return uses

func increment_uses() -> void:
	uses += 1
