extends Node2D


var grid_size = Vector2(64, 64)  # The size of each grid cell.
var grid = []  # The grid.

func _ready():
	# Initialize the grid with empty cells.
	for i in range(get_viewport_rect().size.x / grid_size.x):
		var column = []
		for j in range(get_viewport_rect().size.y / grid_size.y):
			column.append(null)
		grid.append(column)
		
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			print("A key was pressed")
