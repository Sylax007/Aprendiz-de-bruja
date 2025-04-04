extends StaticBody2D

class_name Wall_scene

#var plants = ["clwover","daisy","summer cloud","poppy","lucky clover","mandrake"]
var has_item_drop = true
var rand_plant = "Clover"
var is_timer_paused = true
var hp = 5
var item_dropped = false
var inventory

@onready var timer = $Timer
@onready var plants = get_parent().level_plants
@onready var item_scene = preload("res://scenes/item.tscn")
@onready var all_ingredients = preload("res://Items/all_ingredients.tres")
@onready var item_timer = $has_item_drop
@onready var hp_bar_path = $life_bar
@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if plants:
		rand_plant = plants[randi_range(0,plants.size()-1)]
	inventory = global.inv_generator([rand_plant.to_lower()],randi_range(1,2))


func recover():
	hp *= 1.2
	hp_bar_path.max_value = hp
	hp_bar_path.value = hp
	collision_shape.disabled = false
	visible = true
	
func item_drop():
	#for rand_plant in inventory.items.keys():
	#if inventory.items[rand_plant].quantity != 0:
	if inventory.items:
		var drop = item_scene.instantiate()
		add_sibling(drop)
		drop.global_position = self.global_position
		drop.sprite.texture = inventory.items[rand_plant].texture
		drop.label.text = inventory.items[rand_plant].name
		drop.quantity.text = str(inventory.items[rand_plant].quantity)
		drop.scale = Vector2(0.4,0.4)
		drop.z_index = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hp_bar_path.value <= 0:
		#var items
		#for item in plants:
			#if item in get_parent().level_enemies:
				#items.append(item)
		if has_item_drop:
			has_item_drop = false
			item_drop()
		timer.start()
		is_timer_paused = false
		collision_shape.disabled = true
		visible = false
		#queue_free()
		


func _on_has_item_drop_timeout() -> void:
	has_item_drop = true
