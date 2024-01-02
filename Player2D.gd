extends KinematicBody2D

const SPEED = 150.0

var direction = Vector2.ZERO  # Declare direction here
var velocity = Vector2.ZERO

func _physics_process(delta):
	# Update the direction based on key input
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED  # Apply velocity based on direction
		update_animation()  # Update animation based on movement
	else:
		velocity = Vector2.ZERO  # Stop immediately when there is no input
		$AnimatedSprite.stop()  # Stop the animation
	# Move the character
	# move_and_slide()  # In Godot 4.0, velocity is not passed as an argument

func update_animation():
	var anim_name = "walk_"
	if abs(direction.x) > abs(direction.y):
		anim_name += "left" if direction.x < 0 else "right"
	else:
		anim_name += "up" if direction.y < 0 else "down"
	
	if $AnimatedSprite.animation != anim_name:
		$AnimatedSprite.play(anim_name)
