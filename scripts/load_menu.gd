extends Panel

@onready var itemlist = $VBoxContainer/ItemList


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_draw() -> void:
	var item_index
	var id = 0
	var extension = ".tres"
	while FileAccess.file_exists(global.save_path+str(id)+extension):
		item_index = itemlist.add_item("Save: " + str(id), load("res://assets/menú fondo/fondo menú.png"))
		id += 1


func _on_load_pressed() -> void:
	#global.toggling()
	global.switch_scene("cabin", true)


func _on_cancel_pressed() -> void:
	queue_free()
