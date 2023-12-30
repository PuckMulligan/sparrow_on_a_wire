extends Resource
class_name Exit


var server_1 = null
var server_1_is_locked := false

var server_2 = null
var server_2_is_locked := false


func get_other_server(current_server):
	if current_server == server_1:
		return server_2
	elif current_server == server_2:
		return server_1
	else:
		printerr("the server you tried to find is not connected.")
		return null
 
