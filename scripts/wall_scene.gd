extends StaticBody2D

class_name Wall_scene

@onready var hp_bar_path = $life_bar
@onready var collision_shape = $CollisionShape2D
var is_timer_paused = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func recover():
	hp_bar_path.value = 100
	collision_shape.disabled = false
	visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hp_bar_path.value <= 0 and is_timer_paused:
		$Timer.start()
		is_timer_paused = false
		collision_shape.disabled = true
		visible = false
		
