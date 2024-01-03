extends Node2D

var grid_size = 32
var rules = {}  # The current rules of the game.

func _ready():
	rules["baba"] = "push"

func parse_rules():
	# Clear the current rules.
	rules.clear()

	# Get all the blocks in the game.
	var blocks = get_tree().get_nodes_in_group("blocks")

	# Sort the blocks by their x and y coordinates.
	blocks.sort_custom(self, "compare_blocks")

	# Parse the rules from the blocks.
	for i in range(0, blocks.size() - 2):
		if blocks[i].type == "baba" and blocks[i + 1].type == "is" and blocks[i + 2].type == "you":
			rules["baba"] = "you"

func compare_blocks(a, b):
	if a.global_position.y < b.global_position.y:
		return -1
	elif a.global_position.y > b.global_position.y:
		return 1
	elif a.global_position.x < b.global_position.x:
		return -1
	elif a.global_position.x > b.global_position.x:
		return 1
	else:
		return 0
