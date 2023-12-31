extends Node


func _ready() -> void:
	$HouseServer.connect_exit("outside", $OutsideServer)
