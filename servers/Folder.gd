extends Node
class_name Folder

var _name
var folders = []
var files = []

func _init(_name):
	self.name = _name

func add_folder(folder):
	folders.append(folder)

func add_file(file):
	files.append(file)

func get_folders():
	return folders

func get_files():
	return files
