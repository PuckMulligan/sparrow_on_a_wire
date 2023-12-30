extends PanelContainer
class_name Server


export (String) var server_name = "server Name"
export (String) var server_description = "This is a description of the server."
export (Array) var exits = [] #other servers this server can connect to
export (Dictionary) var subdirectories = {} #a dictionary of the server's contents

func connect_server(current_server, target_server):
	if current_server.exits(target_server):
		pass


		
"""		
func get_full_description() -> String:
	# var exit_string = PoolStringArray(exits.keys()).join(" ") 
	var full_description = PoolStringArray([
		get_server_description(),
		# get_exit_description(),
	]).join("\n")
	return full_description
func get_server_description() -> String:
	return "You are now in: " + server_name + ". It is " + server_description
	

func get_item_description() -> String:
	if items.size() == 0:
		return "No items to pickup."
	var item_string = ""
	for item in items:
		item_string += item.item_name + " "
		
	return "Items: " + item_string
	#return "Items: " + PoolStringArray([])




 	
 func get_exit_description() -> String:
	return "Exits: " + PoolStringArray(exits.keys()).join(" ")
	
 func connect_exit_locked(direction: String, server):
	_connect_exit(direction, server, true)

func connect_exit_unlocked(direction: String, server):
	_connect_exit(direction, server, false)

 func _connect_exit(direction: String, server, is_locked: bool = false):
	var exit = Exit.new()
	exit.server_1 = self
	exit.server_2 = server
	exits[direction] = exit
	
	match direction:
		"west":
			server.exits["east"] = exit
		"east":
			server.exits["west"] = exit
		"south":
			server.exits["north"] = exit
		"north":
			server.exits["south"] = exit
		_:
				printerr("Failed to connect to new server.")
 """
