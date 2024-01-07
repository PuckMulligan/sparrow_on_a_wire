extends KinematicBody2D

# Player script for a puzzle game inspired by "Baba is You"
# Handles player movement and interaction with game elements

export(Vector2) var start_position = Vector2()
var Block = preload("res://Block.gd")
var player_control = false  # Flag to determine if the player has control
enum PlayerState { IDLE, MOVING }
var current_state = PlayerState.IDLE  # Initial player state

# Initialization
func _ready():
	global_position = start_position * get_parent().grid_size
	update_player_control()

# Physics process for handling player input and movement
func _physics_process(delta):
	update_player_control()
	if player_control:
		handle_input()

# Updates the player control status based on the "Baba is You" rule
func update_player_control():
	player_control = is_baba_you()
	if not player_control:
		current_state = PlayerState.IDLE

# Checks if the "Baba is You" rule is active
func is_baba_you() -> bool:
	return get_parent().rules_manager.is_rule_active("baba", "you")

# Handles player input for movement
func handle_input():
	var direction = Vector2()
	if Input.is_action_just_pressed("ui_right"):
		direction.x += 1
	elif Input.is_action_just_pressed("ui_left"):
		direction.x -= 1
	elif Input.is_action_just_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_just_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		move_player(direction)

# Moves the player in the given direction
func move_player(direction):
	var new_position = global_position + direction * get_parent().grid_size
	handle_movement(new_position, direction)

# Handles the movement logic, checking for collisions
func handle_movement(new_position, direction):
	var bodies = get_world_2d().direct_space_state.intersect_point(new_position)
	if bodies.size() == 0:
		global_position = new_position
	elif bodies.size() == 1 and bodies[0].collider.is_in_group("blocks"):
		handle_block_interaction(bodies[0].collider, direction)


# Checks if a block can be pushed
func is_pushable(block) -> bool:
	return get_parent().rules_manager.is_rule_active("block", "push")
# Handles interaction with blocks, such as pushing

func handle_block_interaction(block, direction):
	if is_pushable(block):
		if block.push(direction * get_parent().grid_size):
			global_position += direction * get_parent().grid_size
