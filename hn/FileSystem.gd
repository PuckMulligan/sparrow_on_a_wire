extends Node

class FileEntry:
	var data: String
	var name: String

	func _init(data: String, name: String):
		self.data = data
		self.name = name

class Folder:
	var name: String
	var folders = []
	var files = []

	func _init(name: String):
		self.name = name

	func search_for_folder(name: String) -> Folder:
		for folder in folders:
			if folder.name == name:
				return folder
		return null

	func get_save_string() -> String:
		var save_string = "<folder name=\"" + name + "\">\n"
		for file in files:
			save_string += "<file name=\"" + file.name + "\">" + file.data + "</file>\n"
		for folder in folders:
			save_string += folder.get_save_string()
		save_string += "</folder>\n"
		return save_string

	static func load(file) -> Folder:
		var folder = Folder("")
		while file.get_line() != "<folder>":
			pass
		folder.name = file.get_line().strip_edges(true, false).substr(6, -2)
		while file.get_line() != "</folder>":
			var line = file.get_line()
			if line.begins_with("<file"):
				var name = line.get_slice(" ", 1).substr(6, -2)
				var data = line.get_slice(" ", 2).substr(6, -2)
				folder.files.append(FileEntry(data, name))
			elif line.begins_with("<folder"):
				folder.folders.append(Folder.load(file))
		return folder

class FileSystem:
	var root: Folder

	func _init(empty: bool = false):
		if not empty:
			root = Folder("/")
			root.folders.append(Folder("home"))
			root.folders.append(Folder("log"))
			root.folders.append(Folder("bin"))
			root.folders.append(Folder("sys"))
			generate_system_files()

	func generate_system_files():
		var folder = root.search_for_folder("sys")
		folder.files.append(FileEntry(ThemeManager.get_theme_data_string(OSTheme.HacknetTeal), "x-server.sys"))
		folder.files.append(FileEntry(Computer.generate_binary_string(500), "os-config.sys"))
		folder.files.append(FileEntry(Computer.generate_binary_string(500), "bootcfg.dll"))
		folder.files.append(FileEntry(Computer.generate_binary_string(500), "netcfgx.dll"))

	func get_save_string() -> String:
		return "<filesystem>\n" + root.get_save_string() + "</filesystem>\n"

	static func load(file) -> FileSystem:
		var file_system = FileSystem(true)
		while file.get_line() != "<filesystem>":
			pass
		file_system.root = Folder.load(file)
		return file_system

	func test_equals(obj) -> String:
		if obj is FileSystem:
			return root.test_equals_folder(obj.root)
		else:
			return "Argument is not a FileSystem object"

