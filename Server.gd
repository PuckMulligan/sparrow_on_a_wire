extends PanelContainer
class_name Server


export (String) var server_name = "Server Name"
export (String) var server_description = "This is a description of the server."
export (String) var server_id = "ServerName"
export (String) var ip = "192.161.1.1"
export (int) var security_level = 0

var exits: Dictionary = {}
export (Dictionary) var root = {
	"name": "/",
	"files": [],
	"folders": [
		{"name": "home", "files": [], "folders": []},
		{"name": "log", "files": [], "folders": []},
		{"name": "bin", "files": [], "folders": []},
		{"name": "sys", "files": [], "folders": []}
	]
	}
func generate_sys_files_rewrite():
	pass
	#grab key of sys in root 
	# put it in a variable
	# the variable is called "folder"
	# put the files listed below in it
	# name of our variable "folder"
	#  dictionary key is
	# 	name: /
	# 	files: (the file)
	# 	folders: data
	# then append with the generated binary string.
func _ready():
	generate_system_files()
	

func generate_system_files():
	var folder = search_for_folder("sys")
	if folder != null:
		folder.files.append({"name": "x-server.sys", "data": generate_binary_string(500)})
		folder.files.append({"name": "os-config.sys", "data": generate_binary_string(500)})
		folder.files.append({"name": "bootcfg.dll", "data": generate_binary_string(500)})
		folder.files.append({"name": "netcfgx.dll", "data": generate_binary_string(500)})
	else:
		print("Folder 'sys' not found")
		
func generate_binary_string(length: int) -> String:
	var binary_str = ""
	for i in range(length):
		binary_str += str(randi() % 2)
	return binary_str

func search_for_folder(folder_name: String, current_folder = root) -> Dictionary:
	if current_folder.name == folder_name:
		return current_folder
	for folder in current_folder.folders:
		var result = search_for_folder(folder_name, folder)
		if result != null:
			return result
	return {}
	

func connect_exit(direction: String, server, _override_direction: bool = false):
	match direction:
		"west":
			exits[direction] = server
			server.exits["east"] = self
		"east":
			exits[direction] = server
			server.exits["west"] = self
		"south":
			exits[direction] = server
			server.exits["north"] = self
		"north":
			exits[direction] = server
			server.exits["south"] = self
		"outside":
			exits[direction] = server
			server.exits["house"] = self
