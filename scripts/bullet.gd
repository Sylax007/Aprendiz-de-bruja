extends Area2D

#var velocity

func _ready():
	velocity = get_global_mouse_position()


func _on_area_entered(area: Area2D) -> void:
	get_parent().quit()
