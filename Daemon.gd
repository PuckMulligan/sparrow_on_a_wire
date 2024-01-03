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

	var new_position = global_position + direction * get_parent().grid_size
	var bodies = get_world_2d().direct_space_state.intersect_point(new_position)

	for body in bodies:
		if body.collider is Block:
			body.collider.global_position += direction * get_parent().grid_size

	global_position = new_position
