extends CharacterBody2D

class_name Player_scene

var has_cd = true
var is_input_canceled = false
var spell_instance = null
var animation_timer = Timer.new()
var attack_animation = false
var animation_dir = "down"
var collision = null

@export var speed: Vector2 = Vector2(100,100)
@export var direction: Vector2 = Vector2.ZERO

@onready var player_inventory = global.preloads.player_inventory
@onready var bag_scene = global.preloads.bag_ui
@onready var item_scene = global.preloads.item
@onready var spell = global.preloads.spell


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("attack_down")
	animation_timer.wait_time = ($AnimationPlayer.get_current_animation_length() / $AnimationPlayer.speed_scale)
	$AnimationPlayer.current_animation = "idle_down"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("time is: ",animation_timer.wait_time,"  |  animation length: ",$AnimationPlayer.get_current_animation())
	if not is_input_canceled:
		direction.x = Input.get_axis("a","d")
		direction.y = Input.get_axis("w","s")
		if Input.is_action_pressed("click") and has_cd:
			has_cd = false
			attack_animation = true
			$animation_cd.start()
	velocity.x = delta * speed.x * direction.x
	velocity.y = delta * speed.y * direction.y
	
	#region Detecting clicks to shoot a spell
		#$AnimationPlayer.play("attack_" + last_movement)
		#spell_instance = spell.instantiate()
		#spell_instance.position = global_position
		#spell_instance.vel += self.velocity
		#spell_instance.z_index = 2
		#add_sibling(spell_instance)
	#endregion
	#region This code decides which animation is played using velocity as the reference
	if velocity.length() != 0:
		animation_dir = "down"
		if velocity.x < 0: animation_dir = "left"
		elif velocity.x > 0: animation_dir = "right"
		elif velocity.y < 0: animation_dir = "up"
		if attack_animation and not is_input_canceled:
			$AnimationPlayer.play("attack_" + animation_dir)
		elif is_input_canceled:
			$AnimationPlayer.play("hit_" + animation_dir)
		else:
			$AnimationPlayer.play("walk_" + animation_dir)
	else:
		if attack_animation and not is_input_canceled:
			$AnimationPlayer.play("attack_" + animation_dir)
		elif is_input_canceled:
			$AnimationPlayer.play("hit_" + animation_dir)
		else:
			$AnimationPlayer.play("idle_" + animation_dir)
	#endregion
	
	collision = move_and_collide(velocity)
	if collision:
		#print( "collision is item scene: ",collision.get_collider() is Item_scene)
		if collision.get_collider() is Enemy_scene:
			direction.x *= collision.get_normal().x if collision.get_normal().x else direction.x
			direction.y *= collision.get_normal().y if collision.get_normal().y else direction.y
	velocity = Vector2.ZERO
	#for item in player_inventory.items.keys():
		#if player_inventory.items[item].quantity > 0:
			#print("Player Inventory: ",player_inventory.items[item].name, "quantity is: ",player_inventory.items[item].quantity)
			#print("Global inventory: ",global.inv_template.items[item].name, "quantity is: ",global.inv_template.items[item].quantity)
	

#func _physics_process(delta: float) -> void:
	

#func animation_control(event, key):
	#var xkeys = ["a","d"]
	#var ykeys = ["w","s"]
	#for val in ykeys:
		#$AnimationPlayer.current_animation = 
	#for val in xkeys:
		#
	#return true

#func _input(event):
	

	
