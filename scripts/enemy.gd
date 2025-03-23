extends CharacterBody2D

var hitpoints = 40
@onready var hp_bar = $Sprite2D/hp_container/hp_bar


func _ready():
	hp_bar.max_value = hitpoints
	hp_bar.value = hitpoints
	
