extends CharacterBody2D

class_name Enemy_scene

#@onready var inventory = preload("res://Items/Inventory.tres")
@onready var attacking_timer = $attacking_timer
@onready var movement_timer = $movement_timer
@onready var has_attack_timer = $attack_timer
@onready var aggresive_timer = $aggressive_timer

@onready var item_scene = preload("res://scenes/item.tscn")
@onready var level_enemies = get_parent().level_enemies

@onready var ap = $AnimationPlayer
@onready var hp_bar_path = $hp_bar
#@onready var quantity = $number
#@onready var item_name = $name
@onready var inventory = global.inv_generator(global.enemies["green bunnyslime"],2)
@onready var enemy_sprites = {
	"green bunnyslime": $BabinejoVerdeSep,
	"purple bunnyslime": $BabinejoVioletaSep,
	"white skeleton": $Skelspritesfxmarksep,
	"gold skeleton": $Skelspritesfxmarksep,
	"blue frog": $FrogAzulSep,
	"fire frog": $FrogPrueba
}
#var is_aggressive
#var direction
#var rand_coords
#var speed
#var has_movement_cd
#var has_attack_cd

var angle = 0
var temperature = 0
var collision
var collider
var is_aggressive = null
var enemy_type = ""
var enemy_color = ""
var direction = Vector2(randf(), randf())
var speed = 20
var dmg = 20
var type = ""
var has_movement_cd = true
var has_attack_cd = true
var is_attacking = false
var sprite
var rand_enemy = "green bunnyslime"
@onready var target = get_parent().get_node("player")

func _ready():
	for sprite in enemy_sprites.values():
		sprite.visible = false
	var rand_coords = Vector2(randi()%1200, randi()%500)
	if level_enemies:
		rand_enemy = level_enemies[randi_range(0,level_enemies.size()-1)]
		inventory = global.inv_generator(global.enemies[rand_enemy],randi_range(2,3))
	enemy_color = rand_enemy.split(" ")[0]
	type = rand_enemy.split(" ")[1]
	enemy_sprites[rand_enemy].visible = true
	if rand_enemy == "purple bunnyslime":
		self.hp_bar_path.max_value = 300
		self.hp_bar_path.value = 300
	print(enemy_color, " ", type)
	if enemy_color == "gold" and type == "skeleton":
		self.self_modulate = Color(0.9,0.7,0.2,1)
	#print(global.colors.gold)
	#print(velocity)
	#for letter in rand_enemy:
		#if letter == " ":
			#break
		#enemy_color += letter
		#for val in get_parent().level_enemies:
	sprite = enemy_sprites[rand_enemy]
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

#func random_movement():
##region random movement for the enemy
	#if has_movement_cd:
		#has_movement_cd = false
		#$movement_timer.wait_time = randi()%3+3
		#direction = Vector2(randf(), randf())
##endregion

func move_to_player():
	#nav.target_position = get_parent().get_node("player").get_position()
	#direction = nav.get_next_path_position() - global_position
	#direction = direction.normalized()
	angle = get_angle_to(target.global_position)
	direction = Vector2(sin(angle), cos(angle))

func random_enemy_generator(enemy_list):
	var this_enemy = enemy_list[randi()%len(enemy_list)-1]
	#$AnimationPlayer.play("default")

func _physics_process(delta: float) -> void:
	angle = get_angle_to(target.global_position)
	direction = Vector2(cos(angle), sin(angle))
	#print("angle is:",Vector2(cos(angle),sin(angle)))
		#print("collider detection",collider)
	match type:
		"bunnyslime":
			global_enemies.bunnyslime(self, target, enemy_color)
		"skeleton":
			global_enemies.skeleton(self, target, enemy_color)
		"frog":
			global_enemies.frog(self, target, enemy_color)
	#if not is_aggressive:
		#random_movement()
	
		#print("random movement")
		#random_movement()
	if hp_bar_path.value <= 0:
		item_drop()
		queue_free()
		
	velocity = direction * speed
	collision = move_and_collide(velocity * delta)
	if collision:
		collider = collision.get_collider()
		if collision.get_collider() is Player_scene:
			collider.global_position -= collision.get_normal()*10
			collision.get_collider().life_bar.value -= dmg
	

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
