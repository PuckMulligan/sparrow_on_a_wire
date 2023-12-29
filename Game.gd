extends Control
  

const Response = preload("res://Response.tscn")
const InputResponse = preload("res://InputResponse.tscn")

export (int) var max_lines_remembered := 30

var max_scroll_length := 0

onready var command_processor = $CommandProcessor
onready var history_rows = $Background/MarginContainer/Rows/OutputArea/Scroll/HistoryRows
onready var scroll = $Background/MarginContainer/Rows/OutputArea/Scroll
onready var scrollbar = scroll.get_v_scrollbar()
onready var room_manager = $RoomManager


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	
	create_response("WELCOME TO THE COVEN")
	
	print("Number of children in room_manager: ", room_manager.get_child_count())
	var starting_room = room_manager.get_child(0)
	print("First child of room_manager: ", starting_room)
	
	var starting_room_response = command_processor.initialize(starting_room)
	print("Response from command_processor.initialize: ", starting_room_response)
	
	create_response(starting_room_response)
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


