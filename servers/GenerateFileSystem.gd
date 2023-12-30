extends Node

func generate_random_file_system():
	# Create a new FileSystem object
	var file_system = FileSystem.new()

	# Generate a random number between 0 and 5 (inclusive) for the number of folders
	var num_folders = randi() % 6

	# For each folder to be created
	for i in range(num_folders):
		# Generate a random folder name
		var folder_name = generate_folder_name(randi() % 100)

		# Create a new Folder object with the generated name
		var folder = Folder.new(folder_name)

		# Generate a random number between 0 and 2 (inclusive) for the number of files in this folder
		var num_files = randi() % 3

		# For each file to be created in this folder
		for j in range(num_files):
			# Generate a random file name
			var file_name = generate_file_name(randi() % 300)

			var file_data = ""
			if flip_coin():
				file_data = generate_file_data(randi() % 500)
			else:
				file_data = generate_binary_string(500)
			# Create a new FileEntry object with the generated data and name
			var file = FileEntry.new(file_data, file_name)

			# Add the new file to the folder's file list
			folder.files.append(file)

		# Add the new folder to the root's folder list
		file_system.root.folders[0].folders.append(folder)

	# Return the populated FileSystem object
	return file_system
