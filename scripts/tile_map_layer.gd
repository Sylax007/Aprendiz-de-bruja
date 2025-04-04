extends TileMapLayer

@onready var player = preload("res://scenes/player.tscn")

var level_enemies = ["green_bunny_slime"]
var rand_coords

func _ready() -> void:
	var this_player = player.instantiate()
	add_child(this_player)
	global.spawner(self,2,level_enemies,Vector2(randi()%200, randi()%200))
	$spawn_timer.start()


#func spawner(obj,spawn_number: int, level_enemies: Array,rand_coords: Vector2) -> void:
	#for i in range(spawn_number):
		##print("spawning")
		#rand_coords = Vector2(randi()%200, randi()%200)
		#var enemy = global.preloads.enemy.instantiate()
		#enemy.random_enemy_generator(level_enemies)
		##global.enemy_ids += [enemy.get_instance_id()]
		#obj.add_child(enemy)


func _on_spawn_timer_timeout() -> void:
	#print("spawn working")
	#spawner(2)
	global.spawner(self,2,level_enemies,Vector2(randi()%200, randi()%200))
	$spawn_timer.start()
