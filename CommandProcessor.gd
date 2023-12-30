extends Node


var current_server = null
var player = null
var list_of_files_and_folders = PoolStringArray([])

func initialize(starting_server, starting_player) -> String:
	self.player = starting_player
	return change_server(starting_server)


func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error, no commands parsed."
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
#make cd, ls, cat in commandprocessor
	match first_word:
		"portconnect":
			return portconnect(second_word)
		"ls":
			return ls(second_word)
		"cd":
			return cd(second_word)
		"help":
			return help()
		_:
			return "Such trivialities do not concern me."

func portconnect(second_word):
	var port: bool = false
	if $Port.portconnect(second_word) == true:
		return "you connected"
		
		return "you can't connect to that "

func cd(second_word, is_folder: bool = false, connection: bool = false) -> String:
	if second_word == list_of_files_and_folders.item and is_folder == true and connection == true:
		return "move to that folder, a function in Server.gd"
	
	return "That's not a valid folder"

func ls (second_word) -> String:
	if second_word == null:
		return list_of_files_and_folders
	
	return "That's not a valid folder"

func change_server(new_server) -> String:
	current_server = new_server
	# return new_server.get_full_description()
	return "new server description"
	
	
func help() -> String:
	return "You can use these commands: go [location], help"
	

"""
func inventory (second_word) -> String:
	return player.get_inventory_list(second_word)


func take(second_word: String) -> String:
	if second_word == "":
		return "Take what?"
		
	for item in current_server.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_server.remove_item(item)
			player.take_item(item)
			return "You take the " + item.item_name
			
	return "There is no item like that in this server."
func drop(second_word: String) -> String:
	if second_word == "":
		return "Drop what?"
		
	for item in current_server.items:
		if second_word.to_lower() == item.item_name.to_lower():
			current_server.add_item(item)
			player.drop_item(item)
			return "You drop the " + item.item_name
			
	return "You dont have that."

func go(second_word: String) -> String: #go is broken right now
	if second_word == "":
		return "Go Where?"
	if current_server.exits.keys().has(second_word):
		var exit = current_server.exits[second_word]
		var change_response = change_server(exit)
		return PoolStringArray(["you go %s." % second_word, change_response]).join("\n")
	else:
		return "You can't go that way."


"""


