extends Node2D

const GRID_WIDTH = 24
const GRID_HEIGHT = 18
var grid_size = 32
var rules_manager = RulesManager.new()
var grid = []

func _ready():
	init_grid(GRID_WIDTH, GRID_HEIGHT)
	create_blocks()

func init_grid(width, height):
	for _i in range(height):
		var row = []
		for _j in range(width):
			row.append(null)
		grid.append(row)

func create_blocks():
	for key in rules_manager.elements.keys():
		create_block(key)

func create_block(block_name):
	var block_data = rules_manager.elements[block_name]
	var block = load("res://Block.tscn").instance()
	block.text = block_name
	block.grid_position = block_data["grid_position"]
	block.id = block_data["id"]
	block.rules = block_data["rules"]  # This should now work correctly
	add_child(block)


func get_block_at_grid_position(grid_position):
	for child in get_children():
		if child.grid_position == grid_position:
			return child
	return null
