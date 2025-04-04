extends TileMapLayer

var level_enemies = ["blue frog","white skeleton"]
var level_plants = ["poppy","summer cloud"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.spawner(self,(int($scene_timer.wait_time)%30)-(int($scene_timer.time_left)%30),level_enemies,Vector2(randi()%200, randi()%200))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_forest_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("forest",true)


func _on_spawn_timer_timeout() -> void:
	global.spawner(self,(int($scene_timer.wait_time)%30)-(int($scene_timer.time_left)%30),level_enemies,Vector2(randi()%200, randi()%200))
	$spawn_timer.start()
