extends Node2D

const GRID_WIDTH = 24
const GRID_HEIGHT = 18

var grid = []
var grid_size = 32
var directions = [Vector2.RIGHT, Vector2.DOWN]
var subjects: Dictionary = {}
var objects: Dictionary = {}
var verbs: Dictionary = {}
var blocks: Dictionary = {}

func _ready():
	var log_file = File.new()
	log_file.open("res://debug_log.txt", File.WRITE)
	init_grid(GRID_WIDTH, GRID_HEIGHT)
	init_word_types()
	parse_rules()

func init_grid(width, height):
	for _i in range(height):
		var row = []
		for _j in range(width):
			row.append(null)
		grid.append(row)

func is_in_pixel_bounds(x, y):
	return x >= 0 and x < GRID_WIDTH * grid_size and y >= 0 and y < GRID_HEIGHT * grid_size

func is_in_grid_bounds(x, y):
	return x >= 0 and x < GRID_WIDTH and y >= 0 and y < GRID_HEIGHT


func init_word_types():
	var initial_setup = {
		"baba": {
		"grid_position": Vector2(3, 5),
		 "rules": [""],
		  "id": 0,
		   "word_type": "subject"
		   },

		"block": {
		"grid_position": Vector2(6, 5),
		 "rules": ["push"],
		  "id": 0,
		  "word_type": "subject"
		  },

		"wall": {
		"grid_position": Vector2(9, 5),
		 "rules": [""],
		  "id": 0,
		  "word_type": "subject"
		  },

		"flag": {
		"grid_position": Vector2(12, 5),
		 "rules": [""],
		 "id":  0,
		  "word_type": "subject"
		  },

		"is1": {
		"grid_position": Vector2(3, 6),
		 "rules": [""],
		  "id": 1,
		   "word_type": "verb"
		   },

		"is2": {
		"grid_position": Vector2(6, 6),
		 "rules": [""],
		 "id": 2,
		  "word_type": "verb"
		  },

		"is3": {
		"grid_position": Vector2(9, 6),
		 "rules": [""],
		  "id": 3,
		  "word_type": "verb"
		  },

		"is4": {
		"grid_position": Vector2(12, 6),
		 "rules": [""],
		  "id": 4,
		   "word_type": "verb"
		   },

		"you": {"grid_position": Vector2(3, 7),
		 "rules": [""],
		 "id": 0,
		  "word_type": "object"
		  },

		"push": {
		"grid_position": Vector2(6, 7),
		"rules": ["block"],
		 "id": 0,
		  "word_type": "object"
		  },

		"stop": {
		"grid_position": Vector2(9, 7),
		 "rules": [""],
		  "id": 0,
		   "word_type": "object"
		   },

		"win": {
		"grid_position": Vector2(12, 7),
		 "rules": [""],
		  "id": 0,
		   "word_type": "object"
		   },
		   
	}
	create_blocks(initial_setup)

func create_blocks(initial_setup):
	for block_text in initial_setup.keys():
		var block = load("res://Block.tscn").instance()
		var block_data = initial_setup[block_text]
		var block_grid_position = block_data["grid_position"]
		var block_id = block_data["id"]
		var block_word_type = block_data["word_type"]
		var block_rules = block_data["rules"]
		
		block.text = block_text # Set the text property or any other relevant properties
		block.grid_position = block_grid_position  # Set the grid_grid_position based on the provided grid_position
		block.id = block_id
		block.word_type = block_word_type
		block.rules = block_rules
		
		add_child(block)
		blocks[block_text] = {"grid_position": block_grid_position, "rules": block_rules, "id": block_id}





func is_rule_active(block_name, rule):
	# Ensure that the block exists in the dictionary and has the 'rules' key
	if block_name in blocks and "rules" in blocks[block_name]:
		return rule in blocks[block_name]["rules"]
	return false


func parse_rules():

	var block_instances = get_tree().get_nodes_in_group("blocks")

	for block_instance in block_instances:
		if block_instance.word_type == "subject":
			for direction in directions:
				var rule_sequence = find_rule_sequence(block_instance, direction)
				if rule_sequence:
					apply_rule(rule_sequence)

func find_rule_sequence(block_instance, direction):
	var next_grid_position = block_instance.grid_grid_position + direction
	if is_in_grid_bounds(next_grid_position.x, next_grid_position.y):

		var middle_block = get_block_at_grid_position(next_grid_position)
		if middle_block and middle_block.has("word_type") and middle_block["word_type"] == "verb":
			var next_next_grid_position = middle_block.grid_grid_position + direction
			print("Checking next next grid_position: ", next_next_grid_position)
			if is_in_grid_bounds(next_next_grid_position.x, next_next_grid_position.y):
				var end_block = get_block_at_grid_position(next_next_grid_position)
				print("end block in rule sequence:", end_block)
				if end_block and end_block.has("word_type") and end_block["word_type"] == "object":
					return {
						"subject": block_instance.text,
						"verb": middle_block,
						"object": end_block.text
					}
		else:
			print("middle block is not a verb!")
	return null

func is_verb(block):
	if block is Dictionary and "word_type" in block and block["word_type"] == "verb":
		print(block["word_type"])
		return true
	else:
		print("no block word_type!")
		return false

func get_block_at_grid_position(grid_position):
	for block_name in blocks.keys():
		if blocks[block_name]["grid_grid_position"] == grid_position:
			print("Found block at grid_position: ", grid_position, " Block: ", blocks[block_name])
			return blocks[block_name]
	print("No block found at grid_position: ", grid_position)
	return null

func apply_rule(rule_sequence):
	print("rule sequence in apply rule: ", rule_sequence)
	var subject_name = rule_sequence["subject"]
	var object_name = rule_sequence["object"]

	# Check if the subject and object exist in their respective dictionaries
	if subject_name in subjects and object_name in objects:
		# Retrieve the rule from the object and apply it to the subject
		var rule_to_apply = objects[object_name]["rules"]
		subjects[subject_name]["rules"] = rule_to_apply  # Update the rule
		print("rule to apply: ", rule_to_apply)


""" naaahhhhh

func clear_all_rules():
	for block_name in blocks.keys():
		blocks[block_name]["rules"] = []

"""
