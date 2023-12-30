extends Node

class Computer:
	var name: String
	var ip: String
	var location: Vector2
	var type: int
	var files = []
	var idName: String
	var os: OS
	var traceTime: float = -1.0
	var securityLevel: int
	var adminIP: String
	var users = []
	var adminPass: String
	var ports = []
	var portsOpen = []
	var links = []
	var daemons = []

	func _init(compName: String, compIP: String, compLocation: Vector2, seclevel: int, compType: int, opSystem: OS):
		self.name = compName
		self.ip = compIP
		self.location = compLocation
		self.type = compType
		self.files = generate_random_file_system()
		self.idName = compName.replace(" ", "_")
		self.os = opSystem
		self.securityLevel = seclevel
		self.adminIP = generate_random_ip()
		self.adminPass = PortExploits.getRandomPassword()
		self.users.append(UserDetail.new("admin", adminPass, 1))
		for i in range(seclevel):
			self.ports.append(0)
			self.portsOpen.append(0)
		openPortsForSecurityLevel(seclevel)

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

			# Generate random file data. The method to generate the data is chosen randomly.
			var file_data = generate_random_file_data()

			# Create a new FileEntry object with the generated data and name
			var file = FileEntry.new(file_data, file_name)

			# Add the new file to the folder's file list
			folder.files.append(file)

		# Add the new folder to the root's folder list
		file_system.root.folders[0].folders.append(folder)

	# Return the populated FileSystem object
	return file_system

func generate_file_data(file_data):
	
	if flip_coin():
		file_data = generate_file_data(randi() % 500)
	else:
		file_data = generate_binary_string(500)

	
	
static func generate_random_ip():
	return str(randi() % 256) + "." + str(randi() % 256) + "." + str(randi() % 256) + "." + str(randi() % 256)
