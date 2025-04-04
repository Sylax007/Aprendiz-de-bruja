extends Node2D



var level_enemies = ["purple bunnyslime"]
var level_plants = ["clover","mandrake", "poppy"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.spawner(self,(int($scene_timer.wait_time)%30)-(int($scene_timer.time_left)%30),level_enemies,Vector2(randi()%200, randi()%200))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_entrance_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("cabin", true)


#func _on_spawn_timer_timeout() -> void:
	#global.spawner(self,($scene_timer.wait_time%30)-($scene_timer.time_left%30),level_enemies,Vector2(randi()%200, randi()%200))
	#$spawn_timer.start()
