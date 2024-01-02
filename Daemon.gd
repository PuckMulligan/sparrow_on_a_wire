extends KinematicBody2D

var speed = 200  # The speed of the Daemon.

func _physics_process(delta):
	var direction = Vector2()

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()

	# Calculate the new position.
	var new_position = position + direction * speed * delta

	# Convert the new position to grid coordinates.
	var grid_position = (new_position / get_parent().grid_size).floor()

	# Check if the new cell is empty.
	if get_parent().grid[grid_position.x][grid_position.y] == null:
		# Move to the new cell.
		position = new_position
