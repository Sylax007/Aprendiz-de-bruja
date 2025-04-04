extends Node

@onready var spell = preload("res://scenes/spells.tscn")
@onready var weapon = preload("res://scenes/weapon_scene.tscn")

var spell_instance
var angle
#region Utilities

#region random movement for the enemy
func random_movement(obj):
	if not obj.is_aggressive:
		obj.direction = Vector2(randf(), randf())
#endregion

func animate(obj,function,velocity):
	var animation_dir = "_down"
	velocity *= obj.speed
	if velocity.length() != 0:
		if velocity.x < 0: animation_dir = "_left"
		elif velocity.x > 0: animation_dir = "_right"
		elif velocity.y < 0: animation_dir = "_up"
	#print(animation_dir)
	return function+animation_dir

func attack(obj):
	#var wp = weapon.instantiate()
	#wp.dmg = obj.dmg
	#obj.add_child(wp)
	pass

func set_angle(player,obj):
	angle = obj.angle

func get_distance(obj1, obj2):
	var pos1 = obj1.global_position
	var pos2 = obj2.global_position
	return sqrt((pos2.x-pos1.x)**2 + (pos2.y-pos1.y)**2)
#endregion
#region Enemies Attack


func bunnyslime_attack(obj,color):
	pass
func skeleton_attack(obj,color):
	pass
func frog_attack(obj,color):
	pass
#endregion

#region Enemy Animations
func bunnyslime_animation(obj,direction,color,function):
	obj.ap.play(color+"_bunnyslime/"+animate(obj,function,obj.direction))
func frog_animation(obj,direction,color,function):
	obj.ap.play(color+"_frog/"+animate(obj,function,obj.direction))
func skeleton_animation(obj,direction,color,function):
	obj.ap.play(color+"_skeleton/"+animate(obj,function,obj.direction))
#endregion

#region Enemies Behaviour
func bunnyslime(obj, player, color):
	if get_distance(obj,player) < 200:
		obj.is_aggressive = true
	else:
		random_movement(obj)
	if (color == "purple") and get_distance(obj,player) < 40:
		obj.has_attack_cd = false
		spell_instance = spell.instantiate()
		spell_instance.position = obj.global_position
		spell_instance.set_direction(obj.angle)
		#spell_instance.set_collision_layer(64)
		spell_instance.invoker = obj
		#spell_instance.set_collision_mask(1)
		spell_instance.z_index = 2
		add_sibling(spell_instance)
		obj.direction = obj.direction * -1
		obj.speed = 30
	else:
		if get_distance(obj,player) < 10:
			obj.speed = 1
	obj.speed = 20 if color != "purple" else 30
	if obj.is_aggressive:
		obj.speed = 40
		if obj.has_attack_cd and get_distance(obj,player) <= 20:
			attack(obj)
			bunnyslime_animation(obj,obj.direction,color,"attack")
	else:
		bunnyslime_animation(obj,obj.direction,color,"jump")
	print("angle is:",angle)
		
func frog(obj, player, color):
	if get_distance(obj,player) < 200:
		obj.is_aggressive = true
	else:
		random_movement(obj)
	if color == "fire":
		obj.temperature = 50
		
	if obj.is_aggressive:
		obj.speed = 40
		if obj.has_attack_cd and get_distance(obj,player) <= 20:
			attack(obj)
			frog_animation(obj,obj.direction,color,"attack")
	else:
		obj.speed = 20
		if get_distance(obj,player) < 80:
			obj.speed = 1
		frog_animation(obj,obj.direction,color,"jump")
	
func skeleton(obj, player, color):
	if get_distance(obj,player) < 200:
		obj.is_aggressive = true
	else:
		random_movement(obj)
	if color == "golden":
		obj.dmg = 100
		obj.speed += 1.5
	else:
		obj.dmg = 50
		if get_distance(obj,player) < 30:
			obj.speed = 1
	if obj.is_aggressive:
		obj.speed = 50
		if obj.has_attack_cd and get_distance(obj,player) <= 20:
			attack(obj)
			skeleton_animation(obj,obj.direction,color,"attack")
	else:
		skeleton_animation(obj,obj.direction,color,"walk")
		
	
#endregion
