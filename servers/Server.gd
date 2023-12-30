extends PanelContainer
class_name Server



"""

The following are potential server attributes to be integrated later:
	
# export (Array) var links
# export (Array) var daemons
# export (String) var idName
# export (float) var traceTime 
# export (Vector2) var location

"""


export (String) var server_name = "server Name"
export (String) var server_description = "This is a description of the server."

var ip: String
var securityLevel
var ports: Array
var portsOpen: Array
var os: String
var users: Array = []
var files: Array
var password = generate_random_password(10)
var adminPass: String = generate_random_password(10)
var type: int
var adminIP: String

func _init(server_name: String, server_description: String, compIP: String, compLocation: Vector2, seclevel: int, compType: int, opSystem: OS):
		self.server_name = server_name
		self.server_description = server_description
		self.ip = compIP
		self.location = compLocation
		self.type = compType
		# self.files = generateRandomFileSystem()
		self.idName = server_name.replace(" ", "_")
		self.os = os
		self.securityLevel = seclevel
		self.adminIP = generate_random_IP()
		self.adminPass = generate_random_password(10)
		
		var userDetailList = []
		userDetailList.append(UserDetail.new("admin", adminPass, 1))
		
		for i in range(seclevel):
			self.ports.append(0)
			self.portsOpen.append(0)
		# openPortsForSecurityLevel(seclevel)


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
	
	
func generate_random_password(length):
	var characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var password = ""
	for i in range(length):
		password += characters[randi() % characters.size()]
	return password
func generate_random_IP():
	return str(randi() % 256) + "." + str(randi() % 256) + "." + str(randi() % 256) + "." + str(randi() % 256)


var connection: bool = false
func populate_ports():
	#connect(Port.populate())
	pass
	
func connect_server(current_server, target_server, connection):
	if target_server.firewall(false):
		connection = true
		current_server = target_server
	return "Failed to connect."
		

func get_full_description() -> String:
	# var exit_string = PoolStringArray(exits.keys()).join(" ") 
	var full_description = PoolStringArray([
		get_server_description(),
		# get_exit_description(),
	]).join("\n")
	return full_description
func get_server_description() -> String:
	return "You are now in: " + server_name + ". It is " + server_description
