extends KinematicBody2D

export(Vector2) var start_position = Vector2()
var Block = preload("res://Block.gd")

func _ready():
	global_position = start_position * get_parent().grid_size

func _physics_process(delta):
	var direction = Vector2()

	if Input.is_action_just_pressed("ui_right"):
		direction.x += 1
	elif Input.is_action_just_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_just_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_just_pressed("ui_up"):
		direction.y -= 1

	move_and_push_block(direction)

func move_and_push_block(direction):
	var new_position = global_position + direction * get_parent().grid_size
	var bodies = get_world_2d().direct_space_state.intersect_point(new_position)

	if bodies.size() == 0:
		global_position = new_position
	elif bodies.size() == 1 and bodies[0].collider is Block and is_pushable(bodies[0].collider): #debated is_pushable or is_push. decided we'll check for pushable bc
																									#might wanna add other logic to check if a block is pushable later
		var block_new_position = bodies[0].collider.global_position + direction * get_parent().grid_size
		var block_bodies = get_world_2d().direct_space_state.intersect_point(block_new_position)

		if block_bodies.size() == 0:
			bodies[0].collider.global_position = block_new_position
			global_position = new_position

func is_pushable(block):
	#if block is currently push
	return get_parent().is_rule_active("block","push")
