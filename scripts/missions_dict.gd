extends Resource

class_name AllMissions

var mission = load("res://missions/mission1.tres")
@export var items: Dictionary[Mission, bool] = {mission: false}

#func _ready():
	#items.merge({mission: false})
