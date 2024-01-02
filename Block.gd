extends KinematicBody2D
class_name Block

var speed = 200  # The speed of the Block.

func _ready():
	# Align the block to the grid at the start.
	var grid_position = (global_position / get_parent().grid_size).round()
	global_position = grid_position * get_parent().grid_size


func try_push(direction):
	# Calculate the new grid position.
	var new_grid_position = ((global_position / get_parent().grid_size) + direction).round()

	# Check if the new grid cell is within the grid and is empty.
	if new_grid_position.x >= 0 && new_grid_position.x < len(get_parent().grid) && new_grid_position.y >= 0 && new_grid_position.y < len(get_parent().grid[0]) && get_parent().grid[new_grid_position.x][new_grid_position.y] == null:
		# Move to the new grid cell.
		global_position = new_grid_position * get_parent().grid_size
