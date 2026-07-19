extends Node2D


@onready var penSprite = $Pen
@onready var topLeftB = $Pen/TopLeftBorders
@onready var botRightB = $Pen/BottomRightBorders

@onready var collectionSprite = $Collection/block

@onready var spawner = $Spawner
@onready var bag = $Bag

@onready var client = $Person
@onready var clientHint = $PersonHint

var held: Node
var locked: bool = false



var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Background.set_background("spawn")
	
	Global.penTopLeftBorder = topLeftB.global_position
	Global.penBotRightBorder = botRightB.global_position
	
	var info = StageLoadedInfo
	bag.set_bag(info.get_hotbar())
	spawner.config_preferences(info.get_valid_preferences(), info.get_answer_personality())
	spawner.spawn_pets(info.get_numPets(), info.get_petTexture())
	
	penSprite.texture = info.get_stageTexture()
	collectionSprite.texture = info.get_floorTexture()
	client.texture = info.get_playClient()
	clientHint.texture = info.get_playHint()
	
	spawner.hold_pet.connect(hold_something)
	bag.hold_item.connect(hold_something)
	
	set_process(false)
	set_process_input(false)
	
	
	health = Global.GameStats.Health
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	held.set_global_position(get_global_mouse_position())
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released("LMB"):
		held.place()
		set_process(false)
		set_process_input(false)
	pass

func hold_something(new_holding: Node) -> void:
	held = new_holding
	set_process_input(true)
	set_process(true)
	pass
