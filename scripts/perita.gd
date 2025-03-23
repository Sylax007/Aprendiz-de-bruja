extends CharacterBody2D

@export var speed: Vector2 = Vector2(100,100)
@export var direction: Vector2 = Vector2.ZERO
@export var gravity: Vector2 = Vector2.ZERO
#@export var pos: Vector2 = Vector2.ZERO
var collision = null
# Called when the node enters the sceneos tree for the first time.
func _ready() -> void:
	$AnimationPlayer.current_animation = "idle_abajo"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("a","d")
	direction.y = Input.get_axis("w","s")
	velocity.x = delta * speed.x * direction.x
	velocity.y = delta * speed.y * direction.y
	#pos += velocity * delta
	collision = move_and_slide()
	#collision = move_and_collide(pos)
	#if collision:
		#velocity.x *= collision.get_normal().x if collision.get_normal().x else velocity.x
		#velocity.y *= collision.get_normal().y if collision.get_normal().y else velocity.y
	print("position is:",position,"Velocity is:",velocity)
	print("Collision is:",collision)
	velocity = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("w"):
		$AnimationPlayer.current_animation = "camina_arriba"
	if event.is_action_pressed("a"):
		$AnimationPlayer.current_animation = "camina_izquierda"
	if event.is_action_pressed("s"):
		$AnimationPlayer.current_animation = "camina_abajo"
	if event.is_action_pressed("d"):
		$AnimationPlayer.current_animation = "camina_derecha"
	if event.is_action_released("w"):
		$AnimationPlayer.current_animation = "idle_arriba"
	if event.is_action_released("a"):
		$AnimationPlayer.current_animation = "idle_izquierda"
	if event.is_action_released("s"):
		$AnimationPlayer.current_animation = "idle_abajo"
	if event.is_action_released("d"):
		$AnimationPlayer.current_animation = "idle_derecha"
