extends TextureRect

var start_x = 0
var start_y = 0

@onready var pattern = $Pattern

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_x = pattern.position.x
	start_y = pattern.position.y
	pass # Replace with function body.

func set_background(name: String) -> void:
	texture = backgrounds.get(name).get("back")
	pattern.texture = backgrounds.get(name).get("tile")

func _process(delta: float) -> void:
	_move_tiles(delta)
	pass

func _move_tiles(delta: float):
	var offset = 50 * delta
	pattern.position.x -= offset
	pattern.position.y -= offset * 1.07058823529 #texture not 45 degree angle
	
	if (pattern.position.x <= start_x - 170):
		pattern.position.x = start_x
		pattern.position.y = start_y


var backgrounds: Dictionary[String, Dictionary] = {
	"motion" : {
		"back" = preload("res://sprites/backgrounds/Blue_background.png"),
		"tile" = preload("res://sprites/backgrounds/Blue_logo_logo.png")
		},
	"select" : {
		"back" = preload("res://sprites/backgrounds/Yellow_background.png"),
		"tile" = preload("res://sprites/backgrounds/Yellow_logo.png")
		},
	"spawn" : {
		"back" = preload("res://sprites/backgrounds/green_background.png"),
		"tile" = preload("res://sprites/backgrounds/Green_logo.png")
		},
	"packing" : {
		"back" = preload("res://sprites/backgrounds/Blue_background.png"),
		"tile" = preload("res://sprites/backgrounds/Blue_logo_logo.png")
		},
	"catalogue" : {
		"back" = preload("res://sprites/backgrounds/Pink_background.png"),
		"tile" = preload("res://sprites/backgrounds/Pink_logo.png")
		}
}
