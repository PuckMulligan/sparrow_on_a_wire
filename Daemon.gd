extends KinematicBody2D

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

	# Calculate the new grid position.
	var new_grid_position = ((global_position / get_parent().grid_size) + direction).round()

	# Check if the new grid cell is within the grid.
	if new_grid_position.x >= 0 && new_grid_position.x < len(get_parent().grid) && new_grid_position.y >= 0 && new_grid_position.y < len(get_parent().grid[0]):
		# Try to move to the new grid cell.
		var collision = move_and_collide(direction * get_parent().grid_size)
		if collision:
			# If there's a collision, check if it's a block and try to push it.
			if collision.collider is Block:
				collision.collider.try_push(direction)
