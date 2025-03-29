extends CharacterBody2D

class_name Enemy_scene

#@onready var inventory = preload("res://Items/Inventory.tres")
@onready var item_scene = preload("res://scenes/item.tscn")

@onready var hp_bar_path = $hp_bar
@onready var quantity = $number
@onready var item_name = $name
@onready var inventory = global.inv_generator(global.enemies["green_bunny_slime"],2)
@onready var nav: NavigationAgent2D = $NavigationAgent2D

#var is_aggressive
#var direction
#var rand_coords
#var speed
#var has_movement_cd
#var has_attack_cd
var collision
var collider
var is_aggressive = null
var direction = Vector2(randf(), randf())
var rand_coords = Vector2(randi()%500, randi()%400)
var speed = 20
var has_movement_cd = true
var has_attack_cd = true

@onready var target = get_parent().get_node("player")

func _ready():
	#is_aggressive = null
	#direction = Vector2(randf(), randf())
	#rand_coords = Vector2(randi()%500, randi()%400)
	#speed = 20
	#has_movement_cd = true
	#has_attack_cd = true
	global_position = rand_coords
	
	#Generates inventory for the enemy, using the global.gd function
	#for item_name in gen.keys():
		#gen[item_name]
			#print(inventory.items[item].quantity)
	#print(inventory.items)

func random_movement():
#region random movement for the enemy
	if has_movement_cd:
		has_movement_cd = false
		$movement_timer.wait_time = randi()%3+3
		direction = Vector2(randf(), randf())
#endregion

func move_to_player():
	#nav.target_position = get_parent().get_node("player").get_position()
	#direction = nav.get_next_path_position() - global_position
	#direction = direction.normalized()
	var angle = get_angle_to(target.get_position())
	direction = Vector2(cos(angle), sin(angle))

func random_enemy_generator(enemy_list):
	var this_enemy = enemy_list[randi()%len(enemy_list)-1]
	#$AnimationPlayer.play("default")

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	collision = move_and_collide(velocity * delta)
	if collision:
		collider = collision.get_collider()
		#print("collider detection",collider)
		
	if is_aggressive:
		move_to_player()
		speed = 40
		#behaviour([move_to_player])
		#move_to_player()
	else:
		random_movement()
		speed = 20
		#print("random movement")
		#random_movement()
	if hp_bar_path.value <= 0:
		item_drop()
		queue_free()
	

func item_drop():
	for item_name in inventory.items.keys():
		if inventory.items[item_name].quantity != 0:
			var drop = item_scene.instantiate()
			add_sibling(drop)
			drop.global_position = self.global_position
			drop.sprite.texture = inventory.items[item_name].texture
			drop.label.text = inventory.items[item_name].name
			drop.quantity.text = str(inventory.items[item_name].quantity)
			drop.scale = Vector2(0.4,0.4)
			drop.z_index = 2
