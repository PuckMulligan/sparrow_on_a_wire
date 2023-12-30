extends PanelContainer
class_name Port


var services: Dictionary = {}


func portpopulate():
	
	pass


func portconnect(second_word):
	if firewall(true):
		return "you can't connect to that "
		
	return "you connected"
		
func firewall (is_firewall: bool = false):
	if is_firewall == true:
		return "there is no firewall"
		#enable portbreaker
	return "You can't bypass the firewall"

