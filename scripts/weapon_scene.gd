extends Node2D

class_name Weapon_scene

@onready var duration_timer = $duration_timer

var dmg = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		body.hp_bar_path.value -= dmg
		body.is_invulnerable = true
		body.inv_timer.start()
		queue_free()
