extends PanelContainer
class_name Server


export (String) var server_name = "Server Name"
export (String) var server_description = "This is a description of the server."
export (String) var server_id = "ServerName"
export (String) var ip = "192.161.1.1"
export (int) var security_level = 0
export (Dictionary) var root = {
	"name": "/",
	"files": [],
	"folders": [
		{"name": "home", "files": [], "folders": []},
		{"name": "log", "files": [], "folders": []},
		{"name": "bin", "files": [], "folders": []},
		{"name": "sys", "files": [
			{"name": "bootcfg.dll", "content": "this is the content of bootcfg"},
			{"name": "netcfgx.dll", "content": "this is the content of netcfgx"},
			{"name": "x-server.sys", "content": "this is the content of xserver"},
			{"name": "os-config.sys", "content": "this is the content of xserver"}
		], "folders": []}
	]
}
var exits: Dictionary = {}	

var current_folder = root
var starting_folder = root

func get_current_folder():
	return current_folder
	
func set_current_folder(folder):
	current_folder = folder
""""
to be implemented later:
		
func set_parents(folder):
	for child_folder in folder["folders"]:
		child_folder["parent"] = folder
		set_parents(child_folder)
"""		

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
