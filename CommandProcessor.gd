extends Node


var current_server = null
var current_folder = null
var starting_folder = null


func initialize(starting_server) -> String:
	var response = change_server(starting_server)
	current_folder = current_server.root
	starting_folder = current_server.root
	return response


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
		"ls":
			return ls()
		"cd":
			return cd(second_word)
		"cat":
			return cat(second_word)
		"rm":
			return rm(second_word)
		"nmap":
			return nmap()
		"help":
			return help()

		_:
			return "Such trivialities do not concern me."

func nmap() -> String:
	var network_info = "Network Connections:\n"
	for connection in current_server.exits:
		network_info += " - " + connection + ": " + str(current_server.exits[connection]) + "\n"
	return network_info
		
func cat(file_name: String):
	for file in current_folder["files"]:
		if file["name"] == file_name:
			return file["content"]
		return "File not found"
		

func rm(file_name: String):
	for i in range(len(current_folder["files"])):
		if current_folder["files"][i]["name"] == file_name:
			current_folder["files"].remove(i)
			return "File " + file_name + " removed"
	return "File not found"

func cd(folder_name: String):
	var folder_stack = [current_server.root]
	while folder_stack.size() > 0:
		current_folder = folder_stack.pop_front()
		if current_folder.name == folder_name:
			current_folder = current_folder
			return "Changed to folder: " + folder_name
		for folder in current_folder.folders:
			folder_stack.append(folder)
	return "You can't change to that folder"

func ls() -> String:
	var folder_names = []
	for folder in current_folder["folders"]:
		folder_names.append(folder["name"])
	
	var file_names = []
	for file in current_folder["files"]:
		file_names.append(file["name"])
	
	var folder_string = PoolStringArray(folder_names).join("\n")
	var file_string = PoolStringArray(file_names).join("\n")
	
	return folder_string + "\n" + file_string

func go(second_word: String) -> String:
	if second_word == "":
		return "Go Where?"
	if current_server.exits.keys().has(second_word):
		var change_response = change_server(current_server.exits[second_word])
		return PoolStringArray(["you go %s." % second_word, change_response]).join("\n")
	else:
		return "You can't go that way."

func help() -> String:
	return "You can use these commands: go [location], help, ls, cd [folder], rm [file], cat [file]"

func change_server(new_server) -> String:
	current_server = new_server
	var exit_string = PoolStringArray(new_server.exits.keys()).join(" ")
	var strings = PoolStringArray([
		"You are now in: " + new_server.server_name + ". It is " +new_server.server_description,
		"IP: " + new_server.ip,
		"Exits: " + exit_string
	]).join("\n")
	return strings
