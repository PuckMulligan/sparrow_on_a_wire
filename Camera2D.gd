extends Camera2D

# Reference to the player character (or the node you want to follow)
var player_character

func _ready():
	# Set the initial position to center on the character
	if player_character:
		position = player_character.position

func _process(delta):
	# Follow the character's position
	if player_character:
		position = player_character.position
