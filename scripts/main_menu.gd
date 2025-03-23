extends Control


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file(global.scene_dict.tilemap)


func _on_continue_pressed() -> void:
	pass


func _on_load_game_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
