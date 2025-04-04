extends CharacterBody2D

class_name Player_scene

var current_song
var current_scene
var current_spell
var current_potions: Array[InvItem]
var untoggled = false
var has_cd = true
var is_input_canceled = false
var spell_instance = null
var animation_timer = Timer.new()
var attack_animation = false
var is_invulnerable = false
var animation_dir = "down"
var collision = null
var saving_timer = Timer.new()
var player_missions = AllMissions.new()
var coins: int
var angle = null

@export var speed: Vector2 = Vector2(100,100)
@export var direction: Vector2 = Vector2.ZERO

@onready var spell = preload("res://scenes/spells.tscn")
@onready var inv_timer = $invulnerability_timer
@onready var life_bar = $TextureProgressBar
@onready var audio_stream = $AudioStreamPlayer
@onready var camera_box = $Camera2D/BoxContainer
@onready var player_inventory = preload(global.res_dict["player_inventory"])
@onready var bag_scene = preload(global.scene_dict["bag_ui"])
@onready var item_scene = preload(global.scene_dict["item"])
#@onready var spell = preload(global.scene_dict["spell"])


var _timer_timeout = func():
	global.saving.scene = current_scene
	global.saving.player_inv.items = player_inventory.items
	global.saving.missions.items = player_missions.items
	global.saving.coins = coins
	global.saving.spells.items
	global.saving.current_spell = current_spell
	global.saving.current_potions = current_potions

#func change_song():
	#var file = FileAccess.open(global.current_song, FileAccess.READ)
	#var buffer = file.get_buffer(file.get_len())
	#var stream = AudioStreamMP3.new()
	#stream.data = buffer
	#audio_stream.set_playing(true)
	#current_song = global.current_song


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(global.res_dict["player_inventory"])
	if global.saving:
		current_scene = global.saving.scene
		current_spell = global.saving.current_spell
		current_potions = global.saving.current_potions
	saving_timer.wait_time = 10
	saving_timer.one_shot = false
	saving_timer.connect("timeout", _timer_timeout.bind())
	global.player = self
	global.camera_box = self.camera_box
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
			#region Detecting clicks to shoot a spell
			#$AnimationPlayer.play("attack_" + last_movement)
			spell_instance = spell.instantiate()
			angle = get_angle_to(get_global_mouse_position())
			spell_instance.set_direction(angle)
			spell_instance.invoker = self
			#spell_instance.dir = Vector2(cos(angle), sin(angle))
			#spell_instance.vel += Vector2(speed.x * dir.x, dir.y * speed.x)
			#spell_instance.rotation = angle
			spell_instance.position = global_position
			spell_instance.vel += self.velocity * speed.x
			spell_instance.z_index = 2
			add_sibling(spell_instance)
			#endregion
	velocity.x = delta * speed.x * direction.x
	velocity.y = delta * speed.y * direction.y
	#if current_song != global.current_song:
		#change_song()
	
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
		var collider = collision.get_collider()
		if collider is Weapon_scene:
			life_bar.value -= collider.dmg
		elif collider is Enemy_scene:
			life_bar.value -= collider.dmg * delta/3
		#elif collider.get_collision_layer() == 64 and collider is Spell_scene and not collider is TileMapLayerd:
			#life_bar.value -= collider.damage/3
	if life_bar.value <= 0:
		global.switch_scene("cabin",true)
			#direction.x *= collision.get_normal().x if collision.get_normal().x else direction.x
			#direction.y *= collision.get_normal().y if collision.get_normal().y else direction.y
			
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

func _input(event):
	#var toggled = true in global.toggle.values()
	#if not toggled:
	if event.is_action_pressed("esc"):
		global.display_ui("ingame_menu", camera_box)
	elif event.is_action_pressed("e"):
		global.display_ui("inventory_menu", camera_box)
	elif event.is_action_pressed("q"):
		global.display_ui("mission_menu", camera_box)
	
