extends KinematicBody2D

export (String) var text = ""
export(Vector2) var start_position = Vector2()

func _ready():
	global_position = start_position * get_parent().grid_size
	var label = $Label
	label.text = text
