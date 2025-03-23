extends CharacterBody2D

var bullet = preload("res://scenes/spells.tscn")
var bullet_instance = null
var cd = true
var animation_timer = Timer.new()
var attack_animation = false
@export var speed: Vector2 = Vector2(100,100)
@export var direction: Vector2 = Vector2.ZERO
@export var gravity: Vector2 = Vector2.ZERO
var last_movement = ""
var animation_dir = ""
#@export var pos: Vector2 = Vector2.ZERO
var collision = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#animation_timer.wait_time = $AnimationPlayer.current_animation["ataque_abajo"]
	print("current_animation",$AnimationPlayer["current_animation"])
	$AnimationPlayer.current_animation = "idle_abajo"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction.x = Input.get_axis("a","d")
	direction.y = Input.get_axis("w","s")
	velocity.x = delta * speed.x * direction.x
	velocity.y = delta * speed.y * direction.y
	
	#last_movement.y = -1 if Input.is_action_pressed("w") else 1 if Input.is_action_pressed("s") else 0
	#last_movement.x = -1 if Input.is_action_pressed("a") else 1 if Input.is_action_pressed("d") else 0
	if velocity.length() != 0:
		animation_dir = "abajo"
		if velocity.x < 0: animation_dir = "izquierda"
		elif velocity.x > 0: animation_dir = "derecha"
		elif velocity.y < 0: animation_dir = "arriba"
	if velocity.length() == 0:
		#if attack_animation:
			#$AnimationPlayer.play("attack_" + animation_dir)
		#else:
			$AnimationPlayer.play("idle_" + animation_dir)
	else:
		#if attack_animation:
			#$AnimationPlayer.play("attack_" + last_movement)
		#else:
			$AnimationPlayer.play("camina_" + animation_dir)
	#pos += velocity * delta
	#collision = move_and_slide()
	collision = move_and_collide(velocity)
	if collision:
		velocity.x *= collision.get_normal().x if collision.get_normal().x else velocity.x
		velocity.y *= collision.get_normal().y if collision.get_normal().y else velocity.y
	velocity = Vector2.ZERO

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
	if event.is_action_pressed("click") and cd:
		cd = false
		attack_animation = true
		$Timer.start()
		#$AnimationPlayer.play("ataque_" + last_movement)
		bullet_instance = bullet.instantiate()
		bullet_instance.position = global_position
		bullet_instance.vel += self.velocity
		bullet_instance.z_index = 2
		add_sibling(bullet_instance)
	

#func _input(event):


func _on_timer_timeout() -> void:
	cd = true
