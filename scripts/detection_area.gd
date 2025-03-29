extends Area2D
	
class_name Detection_area

var enemy = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if enemy:
		#print("is enemy aggressive? ",enemy.is_aggressive)
	


func _on_body_exited(body: Node2D) -> void:
	if body is Enemy_scene:
		#print(body)
		if body.is_aggressive == true:
			body.get_node("aggressive_timer").start()
		##print("body exited detected")
	#pass


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy_scene:
		enemy = body
		body.is_aggressive = true
		enemy.hp_bar_path.value -= 10
		#print("enemy entered zone")
