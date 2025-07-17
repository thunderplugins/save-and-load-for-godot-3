extends Node

# Data
export var data = {}
const save_path = "user://data"

# Options
export var autoload = false
export var autosave = false
export var interval = 60

# Developer Options
var encryption = false ## Never change if the project was executed before!

func _ready() -> void:
	if autoload:
		load_data()
	if autosave:
		$Timer.wait_time = interval
		$Timer.start()

func save_data() -> void:
	var file = File.new()
	if encryption:
		file.open_encrypted_with_pass(save_path, File.WRITE, "thunderwasherein2025")
	else:
		file.open(save_path, File.WRITE)
	file.store_var(data)
	file.close()

func load_data() -> void:
	var file = File.new()
	if file.file_exists(save_path):
		if encryption:
			file.open_encrypted_with_pass(save_path, File.READ, "thunderwasherein2025")
		else:
			file.open(save_path, File.READ)
		data = file.get_var()
		file.close()

func _on_Timer_timeout() -> void:
	save_data()
