extends CharacterBody2D

class_name Spell_scene

@export var speed = Vector2(160,100)
@export var damage = 40
@export var type: String = "love"

var vel: Vector2
var collision = null

func _ready():
#region Calculate angle for the spell
	var angle = get_angle_to(get_global_mouse_position())
	var dir = Vector2(cos(angle), sin(angle))
	vel += Vector2(speed.x * dir.x, dir.y * speed.x)
	rotation = angle
#endregion

func _physics_process(delta: float) -> void:
	collision = move_and_collide(vel * delta)
	if collision:
		var collider = collision.get_collider()
#region Makes the spell dissapear if the spell collides with an enemy
		if collider is Enemy_scene or collider is Wall_scene:
			collider.hp_bar_path.value -= damage
			if type == "love" and collider is not Wall_scene:
				collider.is_aggressive = false
			#print(collider.hp_container.hp_bar.value)
		queue_free()
#endregion
