extends BoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var menu = global.preloads.main_menu.instantiate()
	menu.scale = Vector2(0.3,0.3)
	add_child(menu)
	menu.global_position = Vector2.ZERO
	
	self.scale = Vector2(1,1) / get_parent().zoom.x
	#add_child(global.preloads.main_menu)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print("Zoom is: ",get_parent().zoom)
	#print("Viewport: ",get_viewport().get_visible_rect().size)
	
	
	
