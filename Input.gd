extends LineEdit


func _ready() -> void:
	grab_focus()

func _on_text_submitted(_new_text):
	clear()


func _on_Input_text_entered(_new_text):
	clear()
