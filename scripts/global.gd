extends Node

@onready var root_path = get_tree().root
@onready var current_scene = preload("res://scenes/main_menu.tscn").instantiate()

var is_dragging = false
var is_being_assigned = false
var has_shape_entered = null
var collected_slot = InvItem
var screen_showing
var toggled
var save = {
	"position": Vector2.ZERO,
	"coins": 0,
	"inventory": Inv
}

@export var item_list = {
	"clover": 0,
	"daisy": 0,
	"summer cloud": 0,
	"poppy": 0,
	"lucky clover": 0,
	"mandrake": 0,
	"green droplet": 0,
	"orange droplet": 0,
	"red droplet": 0,
	"blue droplet": 0,
	"yellow droplet": 0,
	"purple droplet": 0,
	"creepy eye": 0,
	"phantom cloth": 0,
	"forbidden meat": 0,
	"bottled soul": 0
}

@export var enemies = {
	"green_bunny_slime": ["green droplet","clover"]
}

@export var enemy_ids: Array

@export var scene_dict = {
	"tilemap":	"res://scenes/tile_map_layer.tscn",
	"scene_loader":	"res://scenes/scene_loader.tscn",
	"player":	"res://scenes/player.tscn",
	"main_menu":	"res://scenes/main_menu.tscn",
	"item":	"res://scenes/item.tscn",
	"inv_ui":	"res://scenes/inv_ui.tscn",
	"inventory":	"res://scenes/inventory.tscn",
	"ingame_menu":	"res://scenes/ingame_menu.tscn"
}

var toggle = {
	"tilemap": false,
	"scene_loader": false,
	"player": false,
	"main_menu": false,
	"items": false,
	"inv_ui": false,
	"inventory": false,
	"ingame_menu": false
}

@onready var preloads = {
	"inv": preload("res://Items/Inventory.tres"),
	"tilemap": preload("res://scenes/tile_map_layer.tscn"),
	"scene_loader": preload("res://scenes/scene_loader.tscn"),
	"main_menu": preload("res://scenes/main_menu.tscn"),
	"player": preload("res://scenes/player.tscn"),
	"item": preload("res://scenes/item.tscn"),
	"bag_ui": preload("res://scenes/bag_ui.tscn"),
	"inventory": preload("res://scenes/inventory.tscn"),
	"ingame_menu": preload("res://scenes/ingame_menu.tscn"),
	"spell": preload("res://scenes/spells.tscn"),
	"enemy": preload("res://scenes/enemy.tscn"),
	"player_inventory": preload("res://Items/player_inventory.tres")
}

#region Create an empty inventory
func empty_inv():
	var empty = Inv.new()
	for item_name in preloads.inv.items.keys():
		empty.items[item_name] = InvItem.new()
		empty.items[item_name].texture = preloads.inv.items[item_name].texture
		empty.items[item_name].name = preloads.inv.items[item_name].name
		empty.items[item_name].description = preloads.inv.items[item_name].description
		empty.items[item_name].recipe = preloads.inv.items[item_name].recipe
		#empty[some_inv[index].name.to_lower()] = some_inv[index]
	return empty
#endregion

#region Slows the time based on the time scale, and duration in realtime seconds
func time_slow(time_scale, duration):
	Engine.time_scale = time_scale
	await get_tree().create_timer(duration * time_scale).timeout
	Engine.time_scale = 1.0
#endregion

@onready var inv_template = empty_inv()

func _ready():
	var main_scene = load(scene_dict.main_menu)
	#var main_scene = preloads.main_menu.instantiate()
	#self.add_child(main_scene)
	

func inv_generator(list, max_loot):
	var inv_generate = {"items": {}}
	var empty_inventory = empty_inv()
	for val in empty_inventory.items.keys():
		if val in list:
			inv_generate.items[val] = empty_inventory.items[val]
			inv_generate.items[val]["quantity"] = randi() % int(max_loot * 1.2) + 1
	return inv_generate


func switch_scene(scene_name, parent_node = root_path.get_child(0)):
	call_deferred("_deferred_switch_scene", scene_dict[scene_name], parent_node)
	
func _deferred_switch_scene(scene_path, parent_node):
	current_scene.queue_free()
	var s = load(scene_path)
	current_scene = s.instantiate()
	print(parent_node)
	parent_node.add_child(current_scene)

func toggling(scene_name: String):
	toggle[scene_name] = not toggle[scene_name]
	if toggle[scene_name]:
		print("toggling working")
		switch_scene(scene_name, preloads.player)
		time_slow(0.1,1)
	else:
		print("toggling not working")
		switch_scene("tilemap")
		Engine.time_scale = 1
		

func _input(event):
	toggled = true in toggle.values()
	if not toggled:
		if event.is_action_pressed("esc"):
			toggling("ingame_menu")
		elif event.is_action_pressed("e"):
			toggling("inventory")
			#if toggle.ingame_menu:
				#switch_scene("ingame_menu")
			#else:
				#switch_scene("tilemap")
		#if event.is_action_pressed("e"):
			#
			#toggle.inventory = not toggle.inventory
			#if toggle.inventory:
				#switch_scene("inventory")
			#else:
				#switch_scene("tilemap")
			
		
	
