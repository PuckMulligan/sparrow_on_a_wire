extends KinematicBody2D

signal block_moved

var text: String = ""
var grid_position: Vector2 = Vector2()
var id: int = 0
var rules: Array = []  # Declare the rules property

func _ready():
	global_position = grid_position * get_parent().grid_size
	var label = $Label
	label.text = text
	add_to_group("blocks")

func push(push_vector) -> bool:
	var new_position = global_position + push_vector
	if can_move_to(new_position):
		global_position = new_position
		#print("block moved") #we're emitting a block moved signal
		emit_signal("block_moved", self)
		return true
	return false

func can_move_to(position) -> bool:
	var bodies = get_world_2d().direct_space_state.intersect_point(position)
	if bodies.empty():
		return true
	elif bodies.size() == 1 and bodies[0].collider.is_in_group("blocks"):
		return bodies[0].collider.push(position - global_position)
	return false
