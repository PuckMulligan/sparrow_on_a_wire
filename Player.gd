extends Node


var inventory: Array = []
var exposure: int = 0
var stealth: int = 0


func take_item (item: Item):
	inventory.append(item)
func drop_item (item: Item):
	if item == null:
		return "you dont have anything."
		
	inventory.erase(item)
	
	
func get_inventory_list() -> String:
	if inventory.size() == 0:
		return "No inventory list."

	var item_string = ""
	for item in inventory:
		item_string += item.item_name + " "
		
	return "Inventory: " + item_string
