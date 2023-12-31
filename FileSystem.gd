extends Node
class_name FileSystem

	


var root = {
	"name": "/",
	"files": [],
	"folders": [
		{"name": "home", "files": [], "folders": []},
		{"name": "log", "files": [], "folders": []},
		{"name": "bin", "files": [], "folders": []},
		{"name": "sys", "files": [], "folders": []}
	]
	}
	print(root)
func initiate():
	generate_system_files()
	print("File system has been generated.")
	print(root)

func generate_system_files():
	var folder = search_for_folder("sys")
	folder.files.append({"name": "x-server.sys", "data": generate_binary_string(500)})
	folder.files.append({"name": "os-config.sys", "data": generate_binary_string(500)})
	folder.files.append({"name": "bootcfg.dll", "data": generate_binary_string(500)})
	folder.files.append({"name": "netcfgx.dll", "data": generate_binary_string(500)})

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
