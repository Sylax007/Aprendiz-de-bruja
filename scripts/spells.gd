extends CharacterBody2D

class_name Spell_scene

@export var speed = 160
@export var damage = 40
@export var type: String = "normal"

var invoker
var angle
var dir
var vel: Vector2
var collision = null

#func _ready():
#region Calculate angle for the spell
	#vel += Vector2(speed.x * dir.x, dir.y * speed.x)
	#rotation = angle
#endregion

func set_direction(angle):
	self.dir = Vector2(cos(angle), sin(angle))
	self.vel += Vector2(speed * dir.x, dir.y * speed)
	self.rotation = angle

func _physics_process(delta: float) -> void:
	collision = move_and_collide(vel * delta)
	if collision:
		var collider = collision.get_collider()
#region Makes the spell dissapear if the spell collides with an enemy
		if invoker is Enemy_scene:
			set_collision_layer_value(4,false)
			set_collision_layer_value(6,true)
			set_collision_mask_value(5,false)
			set_collision_mask_value(1,true)
		if (collider is Enemy_scene or collider is Wall_scene) and not invoker is Enemy_scene:
			collider.hp_bar_path.value -= damage
			if type == "love" and collider is not Wall_scene:
				collider.is_aggressive = false
		elif collider is Player_scene and invoker is Enemy_scene:
			collider.life_bar -= damage/10
			#print(collider.hp_container.hp_bar.value)
		queue_free()
#endregion
