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

func _draw():
	# Draw the grid lines.
	var color = Color(1, 1, 1, 0.5)  # Semi-transparent white.
	for i in range(len(grid)):
		for j in range(len(grid[i])):
			var start = Vector2(i * grid_size.x, j * grid_size.y)
			var end = start + grid_size
			draw_line(start, Vector2(start.x, end.y), color)  # Vertical line.
			draw_line(start, Vector2(end.x, start.y), color)  # Horizontal line.
