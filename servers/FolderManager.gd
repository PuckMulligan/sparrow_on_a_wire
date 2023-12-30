class_name FolderManager


var folders = {}

func create_folder(name):
	var folder = Folder.new(name)
	folders[name] = folder
	return folder

func get_folder(name):
	if name in folders:
		return folders[name]
	return null
