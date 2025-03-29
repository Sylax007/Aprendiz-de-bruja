extends Resource

class_name Enemy_object

@export var animation: String
@export var name: String
@export var collision_damage: int
@export var coins: int
@export var speed: float
@export var weapon = null

func find(string):
	for val in self:
		if val == string:
			return true
	return false
