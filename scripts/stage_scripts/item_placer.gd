extends Node


func spawn(slot: Slot) -> Item:
	var instance = Global.ITEM_SCENE.instantiate()
	instance.set_script(slot.storedItem.get_script())
	add_child(instance)
	
	instance.set_slot(slot)
	instance.setup()
	return instance
