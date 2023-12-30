extends Node

class FileEntry:
	var data
	var name

	func _init(data, name):
		self.data = data
		self.name = name

class Folder:
	var name
	var folders = []
	var files = []

	func _init(name):
		self.name = name

	func search_for_folder(name):
		for folder in folders:
			if folder.name == name:
				return folder
		return null

	func to_json():
		var json = {}
		json["name"] = name
		json["folders"] = [folder.to_json() for folder in folders]
		json["files"] = [{"name": file.name, "data": file.data} for file in files]
		return json

	static func from_json(json):
		var folder = Folder.new(json["name"])
		folder.folders = [Folder.from_json(folder_json) for folder_json in json["folders"]]
		folder.files = [FileEntry.new(file_json["data"], file_json["name"]) for file_json in json["files"]]
		return folder

class FileSystem:
	var root

	func _init(empty = false):
		if not empty:
			root = Folder.new("/")
			root.folders.append(Folder.new("home"))
			root.folders.append(Folder.new("log"))
			root.folders.append(Folder.new("bin"))
			root.folders.append(Folder.new("sys"))
			generate_system_files()

	func generate_system_files():
		var folder = root.search_for_folder("sys")
		folder.files.append(FileEntry.new(ThemeManager.get_theme_data_string("HacknetTeal"), "x-server.sys"))
		folder.files.append(FileEntry.new(Computer.generate_binary_string(500), "os-config.sys"))
		folder.files.append(FileEntry.new(Computer.generate_binary_string(500), "bootcfg.dll"))
		folder.files.append(FileEntry.new(Computer.generate_binary_string(500), "netcfgx.dll"))

	func get_save_string():
		return to_json(root)

	static func load(json_string):
		var file_system = FileSystem.new(true)
		file_system.root = Folder.from_json(JSON.parse(json_string).result)
		return file_system

	func test_equals(obj):
		if obj is FileSystem:
			return root == obj.root
		else:
			return false

	func _to_string():
		return str(root)
