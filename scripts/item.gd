extends Area2D

@onready var is_clicked = false
@onready var offset = null

var is_inside_parameter = false
var is_item_dropped = true
var item_val: InvItem
var some_slot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func drop(some_slot):
	some_slot.item_val.texture = global.collected_slot.texture
	some_slot.item_val.name = global.collected_slot.name
	some_slot.item_val.quantity = global.collected_slot.quantity
	global.collected_slot.texture = null
	global.collected_slot.name = ""
	global.collected_slot.quantity = 0
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and is_inside_parameter:
		offset = get_global_mouse_position() - global_position
		global.is_dragging = true
		
	if Input.is_action_pressed("click") and is_inside_parameter and not global.is_dragging:
		global_position = get_global_mouse_position() - offset
	elif Input.is_action_just_released("click"):
		offset = 0
		global.is_dragging = false
		if global.has_shape_entered:
			drop(global.has_shape_entered)
		

#func _on_mouse_entered() -> void:
	#if not global.is_dragging:
		#is_inside_parameter = true
		#$Sprite2D.scale = Vector2(1.2, 1.2)
#
#
#func _on_mouse_exited() -> void:
	#if not global.is_dragging:
		#is_inside_parameter = false
		#$Sprite2D.scale = Vector2(1, 1)

#func _input(event):
		
