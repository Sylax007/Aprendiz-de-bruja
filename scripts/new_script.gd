extends Resource

class_name Enemy

@export var type: String
@export var animation = PackedScene
@export var is_aggressive = true
@export var has_attack_cd = false
@export var has_movement_cd = false
@export var is_on_fire = false
@export var is_frozen = false
@export var is_poisoned = false

@export var max_health: int
@export var speed: int
@export var weapons: PackedScene
@export var temperature: float
@export var size: int

func behaviour(callable_functions):
	for function in callable_functions:
		function.call(self)
		
