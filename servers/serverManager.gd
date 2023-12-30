extends Node


func _ready() -> void:
	var key = Item.new()
	key.init("Key", Types.ItemTypes.KEY)

#	$HomeServer.connect_exit_unlocked("east", $OutsideServer)
	
#	$OutsideServer.add_item(key)
#	$OutsideServer.connect_exit_locked("north", $LockedServer)

func port_open_or_closed():
	pass
	
func scan_ports():
	pass
	
