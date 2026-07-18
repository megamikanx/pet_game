extends Node2D

#if drop pet near pen edge sometimes gets placed wrong
# if dropped fast when in collection sometimes isnt centered

@onready var spawner = $Spawner
@onready var collection = $Collection
@onready var submitButton = $SubmitButton
@onready var bag = $Bag

var held: Node
var mouse_pressed: bool = false
var locked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bag.set_bag(StageLoadedInfo.get_hotbar())
	spawner.spawn_pets(StageLoadedInfo.get_numPets(), StageLoadedInfo.get_petTexture())
	
	spawner.hold_pet.connect(hold_something)
	bag.hold_item.connect(hold_something)
	collection.body_entered.connect(lock_held_pet)
	collection.body_exited.connect(unlock_held_pet)
	
	submitButton.visible = false
	set_process(false)
	set_process_input(false)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_pressed:
		held.set_position(get_global_mouse_position())
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released("LMB"):
		mouse_pressed = false
		if locked and held is Pet:
			held.set_position(collection.position)
			submitButton.visible = true
		else:
			if held is Pet:
				spawner.unfreeze_pets(held)
			
			held.placed()
			set_process_input(false)
			set_process(false)
		

func hold_something(heldor: Node) -> void:
	held = heldor
	set_process_input(true)
	set_process(true)
	mouse_pressed = true
	submitButton.visible = false #done when pressing LMB to repick pet
	pass


func lock_held_pet(body: Node2D) -> void:
	if body is Pet:
		locked = true

func unlock_held_pet(body: Node2D) -> void:
	if body is Pet:
		locked = false
