extends TileMapLayer

var level_enemies = ["green_bunny_slime"]
var rand_coords

func _ready() -> void:
	spawner(2)
	$spawn_timer.start()

#func _process(delta: float) -> void:
	
func spawner(spawn_number: int) -> void:
	for i in range(spawn_number):
		#print("spawning")
		rand_coords = Vector2(randi()%200, randi()%200)
		var enemy = global.preloads.enemy.instantiate()
		enemy.random_enemy_generator(level_enemies)
		#global.enemy_ids += [enemy.get_instance_id()]
		add_child(enemy)


func _on_spawn_timer_timeout() -> void:
	#print("spawn working")
	spawner(3)
	$spawn_timer.start()
