extends Control

@onready var player_inventory = preload("res://Items/player_inventory.tres")
@onready var load_menu = preload("res://scenes/load_menu.tscn")

func _ready() -> void:
	global.current_scene = get_node(".")
	


func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	#global.toggling()
	#print("new button pressed")
	global.switch_scene("cabin", true)
	


func _on_continue_pressed() -> void:
	#var file_path = global.check_files("res://save")
	#if FileAccess.file_exists(file_path):
		#global.saving = global.loading_function(file_path)
		
	#ResourceSaver.save(Save_res.new(), global.save_path+"0")
	
	global.load_game(global.check_files())
	#global.toggling()
	global.switch_scene("cabin", true)


func _on_load_game_pressed() -> void:
	var load_instance = load_menu.instantiate()
	add_child(load_instance)
	


func _on_quit_pressed() -> void:
	get_tree().quit()
