extends TileMapLayer

#@onready var player_scene = 

@onready var cabin_block = $nodes/cabin_block/CollisionShape2D
@onready var forest_corr_block = $nodes/forest_corr_block/CollisionShape2D
@onready var snow_block = $nodes/snow_block/CollisionShape2D
@onready var valley_block = $nodes/valley_block/CollisionShape2D
@onready var cabin_tp = $nodes/cabin_tp/CollisionShape2D
@onready var forest_corr_tp = $nodes/forest_corr_tp/CollisionShape2D
@onready var snow_tp = $nodes/snow_tp/CollisionShape2D
@onready var valley_tp = $nodes/valley_tp/CollisionShape2D
@onready var spawn_timer = $spawn_timer

var level_enemies = ["green bunnyslime"]
var level_plants = ["clover", "daisy"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var player = global.preloads.player.instantiate()
	#add_child(player)
	#player.global_position = Vector2(-360,424)
	global.spawner(self,(int($scene_timer.wait_time)%30)-(int($scene_timer.time_left)%30),level_enemies,Vector2(randi()%200, randi()%200))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_valley_tp_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("valley", true)


func _on_cabin_tp_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("cabin", true)


func _on_forest_corr_tp_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("forest_corr", true)


func _on_snow_tp_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("snow", true)


func _on_spawn_timer_timeout() -> void:
	global.spawner(self,(int($scene_timer.wait_time)%30)-(int($scene_timer.time_left)%30),level_enemies,Vector2(randi()%200, randi()%200))
	$spawn_timer.start()
