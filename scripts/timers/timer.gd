extends Timer

var spawn_cd = true


func _process(delta: float) -> void:
	if spawn_cd:
		spawn_cd = false
		start()
	


func _on_timeout() -> void:
	spawn_cd = true
	get_parent().spawner(2)
	
