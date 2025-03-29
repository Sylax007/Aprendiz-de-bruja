extends Area2D

class_name Slot_scene

@onready var is_clicked = false
@onready var has_mouse_entered = false
@onready var sprite = $TextureRect
@onready var name_label = $name
@onready var quantity_label = $number

var is_inside_slot = false
var draggable = true
var body_ref
var offset: Vector2


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and not global.is_dragging:
		global.collected_slot = self
		#offset = global_position - get_global_mouse_position()
		#global_position = get_global_mouse_position() - offset
	if Input.is_action_just_released("click") and global.has_shape_entered:
		global.is_being_assigned = true
		


func transfer(callback):
	callback.call(self)
	

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if global.is_dragging:
		global.has_shape_entered = self
		$Sprite2D.scale = Vector2(1.1, 1.1)


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if global.is_dragging:
		global.has_shape_entered = null
		$Sprite2D.scale = Vector2(1, 1)


func _on_mouse_entered() -> void:
	if not global.is_dragging:
		#is_inside_parameter = true
		$Sprite2D.scale = Vector2(1.2, 1.2)


func _on_mouse_exited() -> void:
	if not global.is_dragging:
		#is_inside_parameter = false
		$Sprite2D.scale = Vector2(1, 1)


func _input(event):
	if event.is_action_pressed("click"):
		is_clicked = true
	if event.is_action_released("click") and is_inside_slot:
		is_clicked = false
	elif event.is_action_released("click") and not is_inside_slot:
		is_clicked = false
		
		
