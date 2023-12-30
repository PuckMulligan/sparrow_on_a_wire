extends Node

const MIN_SOLUTION_LENGTH = 6
const OUTPUT_LINE_WIDTH = 20
const CHARS_SOLVED_PER_PASS = 3
const SOLVED_CHAR = "0"

var additional_delay = 0.0
var analysis_passes = 0
var complexity = 1
var solution = ""
var solution_length = 6
var solved = false

func _init(complexity: int, solution: String):
	self.complexity = complexity
	self.solution = solution
	solution_length = solution.length()
	self.complexity = complexity
	solution_length = 6 + complexity
	generate_random_solution()

func generate_random_solution():
	var random_string = ""
	for _i in range(solution_length):
		random_string += chr(randi() % 26 + 65)  # Random uppercase letter
	solution = random_string

func get_save_string() -> String:
	return "<firewall complexity=\"%d\" solution=\"%s\" additionalDelay=\"%f\" />" % [complexity, solution, additional_delay]

func reset_solution_progress():
	analysis_passes = 0

func attempt_solve(attempt: String, os) -> bool:
	if attempt.length() != solution.length():
		var str = attempt.length() < solution.length() ? "Too few characters" : "Too many characters"
		os.write("Solution Incorrect Length - " + str)
	elif attempt.to_lower() == solution.to_lower():
		solved = true
		return true
	return false


func equals(obj) -> bool:
	var firewall = obj as Firewall
	if firewall and firewall.additional_delay == additional_delay and firewall.complexity == complexity:
		return firewall.solution == solution
	return false

func get_hash_code() -> int:
	return hash(solution)  # This is not equivalent to C#'s GetHashCode method, but it's a simple way to get a hash code in GDScript.

func to_string() -> String:
	return "Firewall: solution\"%s\" - time:%f - complexity:%d" % [solution, additional_delay, complexity]
