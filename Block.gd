extends KinematicBody2D

var text: String = ""
var grid_position: Vector2 = Vector2()
var rules: Array = []
var id: int = 0
var word_type: String = ""

func _ready():
	global_position = grid_position * get_parent().grid_size
	var label = $Label
	label.text = text
