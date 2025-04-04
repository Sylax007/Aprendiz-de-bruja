extends StaticBody2D

@onready var player_scene = preload("res://scenes/player.tscn")

var level_plants = ["clover"]

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#var player = player_scene.instantiate()
	#add_child(player)
	#player.global_position = Vector2(360,270)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_forest_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("forest", true)


func _on_cemetery_body_entered(body: Node2D) -> void:
	if body is Player_scene:
		global.switch_scene("cementery", true)
