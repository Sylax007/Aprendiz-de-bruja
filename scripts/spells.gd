extends CharacterBody2D

@export var speed = Vector2(200,100)
@export var damage = 10
var vel: Vector2
var collision = null

func _ready():
	var angle = get_angle_to(get_global_mouse_position())
	rotation = angle
	var dir = Vector2(cos(angle),sin(angle))
	vel += Vector2(speed.x * dir.x, dir.y * speed.x)
	print("Bullet velocity is:", dir)

func _physics_process(delta: float) -> void:
	collision = move_and_collide(vel * delta)
	if collision:
		var collider = collision.get_collider()
			#collider.hp_bar.value -= damage
			#if collider.hp_bar.value <= 0:
				#collider.queue_free()
			
		#print(collider.hp_bar.value)
		queue_free()
