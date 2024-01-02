extends GridContainer


# In the script attached to the Grid node:
const Block = preload("res://Block.tscn")

func _ready():
	for i in range(10):  # Adjust this to the number of blocks you want.
		var block = Block.instance()
		add_child(block)
		
# In the script attached to the Grid node:
func check_statement():
	var statement = [block.text for block in get_children()]
	if statement == ["Shell", "Is", "Stable", "If", "Network", "Secure"]:
		print("Correct statement!")
	else:
		print("Incorrect statement.")
