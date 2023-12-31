extends Node


var current_server = null

func initialize(starting_server) -> String:
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
		"help":
			return help()
		_:
			return "Such trivialities do not concern me."

func go(second_word: String) -> String:
	if second_word == "":
		return "Go Where?"
	if current_server.exits.keys().has(second_word):
		var change_response = change_server(current_server.exits[second_word])
		return PoolStringArray(["you go %s." % second_word, change_response]).join("\n")
	else:
		return "You can't go that way."

func help() -> String:
	return "You can use these commands: go [location], help"

func change_server(new_server) -> String:
	current_server = new_server
	var exit_string = PoolStringArray(new_server.exits.keys()).join(" ")
	var strings = PoolStringArray([
		"You are now in: " + new_server.server_name + ". It is " +new_server.server_description,
		"IP: " + new_server.ip,
		"Exits: " + exit_string
	]).join("\n")
	return strings
