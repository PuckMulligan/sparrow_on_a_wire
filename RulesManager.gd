extends Node
class_name RulesManager

# Signals to notify when a rule is added or removed
signal rule_added(subject, rule)
signal rule_removed(subject, rule)

# Define possible directions for rule checking
var directions = [Vector2.RIGHT, Vector2.DOWN]
# Store game elements and their associated rules
var elements: Dictionary = {}
# Counter for generating unique IDs
var global_id_counter = 0

# Initialization function
func _init():
	initialize_elements()

# Ready function to set up necessary connections
func _ready():
	# Connect each block's movement signal to the rule parsing function
	var block_instances = get_tree().get_nodes_in_group("blocks")
	for block_instance in block_instances:
		block_instance.connect("block_moved", self, "on_block_moved")

# Function to initialize game elements with their properties
func initialize_elements():
	var initial_setup = { # Define initial setup for game elements here
		"baba": {"grid_position": Vector2(3, 5), "rules": ["you"]},
		"block": {"grid_position": Vector2(6, 5), "rules": ["push"]},
		"wall": {"grid_position": Vector2(9, 5), "rules": ["stop"]},
		"flag": {"grid_position": Vector2(12, 5), "rules": ["win"]},
		"is1": {"grid_position": Vector2(3, 6), "rules": [""]},
		"is2": {"grid_position": Vector2(6, 6), "rules": [""]},
		"is3": {"grid_position": Vector2(9, 6), "rules": [""]},
		"is4": {"grid_position": Vector2(12, 6), "rules": [""]},
		"you": {"grid_position": Vector2(3, 7), "rules": [""]},
		"push": {"grid_position": Vector2(6, 7), "rules": [""]},
		"stop": {"grid_position": Vector2(9, 7), "rules": [""]},
		"win": {"grid_position": Vector2(12, 7), "rules": [""]},
	}

	for key in initial_setup.keys():
		add_element(key, initial_setup[key])

# Function to add a new element to the game
func add_element(name: String, data: Dictionary):
	data["id"] = get_unique_id()
	elements[name] = data

# Signal callback when a block is moved
func on_block_moved(block):
	print("signal callback received") #NO SIGNAL CALLBACK RECEIVED
	# Reevaluate rules when a block is moved
	parse_rules()

func parse_rules():
	var block_instances = get_tree().get_nodes_in_group("blocks")
	for block_instance in block_instances:
		evaluate_block_rules(block_instance)

# Function to evaluate rules for a specific block instance
func evaluate_block_rules(block_instance):
	# Check for rule application and removal in each direction
	for direction in directions:
		var next_grid_position = block_instance.grid_position + direction
		var middle_block = get_parent().get_block_at_grid_position(next_grid_position)
		
		if middle_block and is_verb(middle_block):
			var next_next_grid_position = middle_block.grid_position + direction
			var end_block = get_parent().get_block_at_grid_position(next_next_grid_position)
			
			if end_block:
				# Apply rule if a valid sequence is found
				var rule_sequence = {
					"subject": block_instance.text,
					"verb": middle_block.text,
					"object": end_block.text
				}
				apply_rule(rule_sequence)
			else:
				# Remove rule if sequence is broken
				remove_rule(block_instance.text, middle_block.text)

# Function to generate a unique ID for each game element
func get_unique_id() -> int:
	global_id_counter += 1
	return global_id_counter

# Function to apply a rule based on a rule sequence
func apply_rule(rule_sequence):
	var subject_name = rule_sequence["subject"]
	var object_name = rule_sequence["object"]
	
	if elements.has(subject_name) and elements.has(object_name):
		var rule_to_apply = elements[object_name].get("rules", [])
		elements[subject_name]["rules"] = rule_to_apply
		emit_signal("rule_changed", subject_name, rule_to_apply)
	else:
		print("One of the elements in the rule sequence does not exist")

# Function to remove a specific rule from an element
func remove_rule(element_name: String, rule_to_remove: String) -> void:
	if elements.has(element_name) and rule_to_remove in elements[element_name].get("rules", []):
		elements[element_name]["rules"].erase(rule_to_remove)
		emit_signal("rule_removed", element_name, rule_to_remove)
	else:
		print("Rule not found for element:", element_name)

# Utility function to check if a rule is currently active for a given element
func is_rule_active(element_name, rule):
	return element_name in elements and rule in elements[element_name].get("rules", [])

# Utility function to check if a block is a verb
func is_verb(block):
	return block is Dictionary and block.get("word_type") == "verb"

"""

func get_rule_to_remove(block_instance, direction) -> String:
	var opposite_direction = -direction
	var next_grid_position = block_instance.grid_position + opposite_direction
	if get_parent().is_in_grid_bounds(next_grid_position):
		var middle_block = get_parent().get_block_at_grid_position(next_grid_position)
		if middle_block and is_verb(middle_block):
			var next_next_grid_position = middle_block.grid_position + opposite_direction
			if get_parent().is_in_grid_bounds(next_next_grid_position):
				var end_block = get_parent().get_block_at_grid_position(next_next_grid_position)
				if not end_block or not is_valid_rule_sequence(block_instance, middle_block, end_block):
					return middle_block.text  # Return the verb as the rule to remove
	return ""


func get_unique_id() -> int:
	global_id_counter += 1
	return global_id_counter

func apply_rule(rule_sequence):
	var subject_name = rule_sequence["subject"]
	var object_name = rule_sequence["object"]
	
	if elements.has(subject_name) and elements.has(object_name):
		var rule_to_apply = elements[object_name].get("rules", [])
		elements[subject_name].rules = rule_to_apply
		emit_signal("rule_changed", subject_name, rule_to_apply)
	else:
		print("One of the elements in the rule sequence does not exist")

func add_rule(element_name: String, new_rule: String) -> void:
	if elements.has(element_name):
		var current_rules = elements[element_name].get("rules", [])
		if not new_rule in current_rules:
			current_rules.append(new_rule)
			elements[element_name]["rules"] = current_rules
			emit_signal("rule_added", element_name, new_rule)
		else:
			print("Rule already exists for element:", element_name)
	else:
		print("Element not found:", element_name)

		
func find_rule_sequence(block_instance, direction) -> Dictionary:
	var next_grid_position = block_instance.grid_position + direction
	if get_parent().is_in_grid_bounds(next_grid_position):
		var middle_block = get_parent().get_block_at_grid_position(next_grid_position)
		if middle_block and is_verb(middle_block):
			var next_next_grid_position = middle_block.grid_position + direction
			if get_parent().is_in_grid_bounds(next_next_grid_position):
				var end_block = get_parent().get_block_at_grid_position(next_next_grid_position)
				if end_block:
					return {
						"subject": block_instance.text,
						"verb": middle_block.text,
						"object": end_block.text
					}
	return {}  # Return an empty dictionary if no valid rule sequence is found



func is_rule_active(element_name, rule):
	return element_name in elements and rule in elements[element_name].get("rules", [])

func is_verb(block):
	return block is Dictionary and block.get("word_type") == "verb"
"""
