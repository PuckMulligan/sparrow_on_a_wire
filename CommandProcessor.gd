extends Node


var current_server = null
var player = null

func initialize(starting_server, player) -> String:
	self.player = player
	return change_server(starting_server)


func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error, no commands parsed."
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()

	match first_word:
		"go":
			return go(second_word)
		"take":
			return take(second_word)
		"help":
			return help()
		"inventory":
			return inventory(second_word)
		_:
			return "Such trivialities do not concern me."

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

func go(second_word: String) -> String:
	if second_word == "":
		return "Go Where?"
	if current_server.exits.keys().has(second_word):
		var exit = current_server.exits[second_word]
		var change_response = change_server(exit)
		return PoolStringArray(["you go %s." % second_word, change_response]).join("\n")
	else:
		return "You can't go that way."

func help() -> String:
	return "You can use these commands: go [location], help"

func change_server(new_server) -> String:
	current_server = new_server
	var exit_string = PoolStringArray(new_server.exits.keys()).join(" ")
	return new_server.get_full_description()
