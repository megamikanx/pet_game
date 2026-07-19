class_name Spawner
extends Node2D

const OFFSET = 64

signal hold_pet

@onready var collection = get_parent().get_node("Collection")

var valid_preferences: Array[ItemInfo.ITEM_TYPE]
var answer_personality: Dictionary[ItemInfo.ITEM_TYPE, bool]

func spawn_pets(num : int, texture: Texture2D) -> void:
	var offsetX = texture.get_size().x * 0.5 * Global.petScale
	var offsetY = texture.get_size().y * 0.5 * Global.petScale

	var lower_sx = Global.penTopLeftBorder.x + offsetX
	var upper_sx = Global.penBotRightBorder.x - offsetX
	var lower_sy = Global.penTopLeftBorder.y + offsetY
	var upper_sy = Global.penBotRightBorder.y - offsetY
	
	
	var instance: Pet
	for ID in num:
		instance = Global.PET_SCENE.instantiate()
		#Setup connections
		instance.pick_me_up.connect(pet_picked_up)
		instance.pick_me_up.connect(collection.collected_pickedup)
		instance.freeze_pets.connect(freeze_pets)
		instance.unfreeze_pets.connect(unfreeze_pets)
		instance.send_coll.connect(collection.place_pet)
		
		add_child(instance)
		
		instance.position = Vector2(randi_range(lower_sx, upper_sx),
									randi_range(lower_sy, upper_sy))
		instance.goal = Vector2(randi_range(lower_sx, upper_sx),
									randi_range(lower_sy, upper_sy))
		instance.set_petTexture(texture)
		instance.set_ID(ID)
		if ID == 0:
			instance.set_personality(make_answer_personality())
		else:
			instance.set_personality(create_random_personality())
	pass

func create_random_personality() -> Array[ItemInfo.ITEM_TYPE]:
	var personality: Array[ItemInfo.ITEM_TYPE] = []
	for pre in valid_preferences:
		if randi() % 10 < ItemInfo.ITEM.get(pre).get("CHANCE"):
			personality.append(pre)
		
	for key in answer_personality.keys():
		if not ( (answer_personality.get(key)) == (key in personality) ):
			return personality
	
	return create_random_personality()

func make_answer_personality() -> Array[ItemInfo.ITEM_TYPE]:
	var personality: Array[ItemInfo.ITEM_TYPE] = []
	
	for pre in valid_preferences:
		if pre in answer_personality.keys():
			if answer_personality.get(pre):
				personality.append(pre)
		else:
			if randi() % 10 < ItemInfo.ITEM.get(pre).get("CHANCE"):
				personality.append(pre)

	return personality

func config_preferences(valid: Array[ItemInfo.ITEM_TYPE],
		 answer: Dictionary[ItemInfo.ITEM_TYPE, bool]) -> void:
	valid_preferences = valid
	answer_personality = answer
	pass


func pet_picked_up(the_holded : Pet) -> void:
	hold_pet.emit(the_holded)

func freeze_pets() -> void:
	for pet in get_children():
		pet.freeze()

func unfreeze_pets() -> void:
	for pet in get_children():
		pet.unfreeze.call_deferred()
