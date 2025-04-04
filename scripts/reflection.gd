extends Area2D

class_name Reflection

@onready var spell = preload("res://scenes/spells.tscn")
@export var type = "normal"

var spell_instance = null
var has_cd = true
var angle
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(Input.is_action_pressed("click"))
	if Input.is_action_pressed("click") and has_cd:
		has_cd = false
		#if type != "love":
			#$Timer.wait_time = 0.3
		$Timer.start()
		spell_instance = spell.instantiate()
		angle = get_angle_to(get_global_mouse_position())
		spell_instance.set_direction(angle)
		spell_instance.invoker = self
		spell_instance.position = global_position
		spell_instance.vel *= 2
		spell_instance.z_index = 2
		add_sibling(spell_instance)
		#spell_instance = spell.instantiate()
		#spell_instance.global_position = self.global_position
		#spell_instance.z_index = 2
		#add_sibling(spell_instance)


func _on_timer_timeout() -> void:
	has_cd = true
