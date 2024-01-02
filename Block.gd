extends KinematicBody2D
class_name Block

var speed = 200  # The speed of the Block.

func move_block(direction):
	move_and_slide(direction * speed)
