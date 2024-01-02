extends Control
  

const Response = preload("res://Response.tscn")
const InputResponse = preload("res://InputResponse.tscn")

export (int) var max_lines_remembered := 30

var max_scroll_length := 0

onready var command_processor = $CommandProcessor
onready var history_rows = $Background/MarginContainer/HBoxContainer/Terminal/MarginContainer/Rows/OutputArea/Scroll/HistoryRows
onready var scroll = $Background/MarginContainer/HBoxContainer/Terminal/MarginContainer/Rows/OutputArea/Scroll
onready var scrollbar = scroll.get_v_scrollbar()
onready var server_manager = $ServerManager


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	
	create_response("Greetings Seeker,")
	create_response("If you're reading this, you've delved deeper than most dare to tread. Your skills are commendable, but the true test lies ahead. ")
	create_response("In the shadows of the wired abyss, where ancient codes intertwine with forgotten runes, lies the Arcane Vault. It holds a secret, a powerful tool that can bend the digital ether to your will.")
	create_response("But beware, the path is veiled. To find the Vault, seek the Server of the Crescent Moon. Its key lies hidden in the astral echoes of cyberspace, encrypted by the Witches of the Binary Coven.")
	create_response("Listen to the whispers in the data wind. Follow the trail of spectral bytes. Only then can the Vault be unlocked, and its secrets be yours.")
	create_response("May the cyber-winds guide you,")
	create_response("~ A Friend in the Shadows")
	
	print("Number of children in server_manager: ", server_manager.get_child_count())
	var starting_server = server_manager.get_child(0)
	print("First child of server_manager: ", starting_server)
	
	var starting_server_response = command_processor.initialize(starting_server)
	print("Response from command_processor.initialize: ", starting_server_response)
	
	create_response(starting_server_response)
func create_response(response_text):
	var response = Response.instance()
	response.text = response_text
	print(response_text)
	add_response_to_game(response)

func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length

func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return

	var input_response = InputResponse.instance()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)
	history_rows.add_child(input_response)
	
func add_response_to_game(response: Control):
	history_rows.add_child(response)
	# delete_history_beyond_limit()
	
	# func for deleting history goes here
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()


