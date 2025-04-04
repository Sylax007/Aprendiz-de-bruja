extends Control

#@onready var player_inventory = preload("res://Items/player_inventory.tres")

func _on_status_pressed() -> void:
	global.display_ui("status_menu", global.camera_box)


func _on_orders_pressed() -> void:
	global.display_ui("mission_menu", global.camera_box)


func _on_recipes_pressed() -> void:
	global.display_ui("inventory_menu", global.camera_box)


func _on_shop_pressed() -> void:
	global.display_ui("shop_menu", global.camera_box)


func _on_collecting_pressed() -> void:
	global.display_ui("collecting_menu", global.camera_box)


func _on_quit_pressed() -> void:
	get_tree().quit()
