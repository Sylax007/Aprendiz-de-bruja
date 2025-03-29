extends Area2D

class_name Item_scene

@onready var is_clicked = false
@onready var offset = null
@onready var sprite = $Sprite2D
@onready var label = $Name_label
@onready var quantity = $Quantity_label

@export var velocity = Vector2(100,100)


var collision = null
var is_inside_parameter = false
var deceleration = Vector2(1,1)
var some_slot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var initial_velocity = Vector2((randi() % int(velocity.x)) - velocity.x/2, (randi() % int(velocity.y)) - velocity.y/2)
	var initial_velocity_vector = sqrt(initial_velocity.x**2 + initial_velocity.y**2)
	var velocity_vector = sqrt(velocity.x**2 + velocity.y**2)
	deceleration.x *= initial_velocity.x/abs(initial_velocity.x)
	deceleration.y *= initial_velocity.y/abs(initial_velocity.y)
	
	if initial_velocity_vector < velocity_vector/3:
		var difference = (((velocity_vector/initial_velocity_vector)-1)/3)+1
		initial_velocity *= difference
	velocity = initial_velocity

func _physics_process(delta: float) -> void:
	if not (abs(velocity.x) < 10 or abs(velocity.y) < 10):
		#print("velocity: ",velocity,"   deceleration",deceleration)
		global_position += velocity * delta
		velocity.x -= deceleration.x
		velocity.y -= deceleration.y
	


#func item_click():
	#if Input.is_action_just_pressed("click") and is_inside_parameter:
		#offset = get_global_mouse_position() - global_position
		#global.is_dragging = true
		#
	#if Input.is_action_pressed("click") and is_inside_parameter and not global.is_dragging:
		#global_position = get_global_mouse_position() - offset
	#elif Input.is_action_just_released("click"):
		#offset = 0
		#global.is_dragging = false
		#if global.has_shape_entered:
			#drop(global.has_shape_entered)
		

func _on_mouse_entered() -> void:
	if not global.is_dragging:
		is_inside_parameter = true
		$Sprite2D.scale = Vector2(1.2, 1.2)


func _on_mouse_exited() -> void:
	if not global.is_dragging:
		is_inside_parameter = false
		$Sprite2D.scale = Vector2(1, 1)

#func _input(event):
		


func _on_body_entered(body: Node2D) -> void:
	var node = get_node(body.get_path())
	if node is Player_scene:
		node.player_inventory.items[label.text.to_lower()].quantity += int(quantity.text)
		var this_player = get_node(body.get_path()).player_inventory.items[label.text.to_lower()]
		print(this_player.name," quantity is: ",this_player.quantity)
		queue_free()
	
