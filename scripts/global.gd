extends Node

var is_dragging = false
var is_being_assigned = false
var has_shape_entered = null
var collected_slot = InvItem
var screen_showing

var save = {
	
}

@export var item_list = {
	"clover": "res://assets/ingredient list/1.Clover.png"
}

@export var preloads = {
	"tilemap":	preload("res://scenes/tile_map_layer.tscn"),
	"scene_loader":	preload("res://scenes/scene_loader.tscn"),
	"player":	preload("res://scenes/player.tscn"),
	"main_menu":	preload("res://scenes/main_menu.tscn"),
	"items":	preload("res://scenes/item.tscn"),
	"inv_ui":	preload("res://scenes/inv_ui.tscn"),
	"inventory":	preload("res://scenes/inventory.tscn"),
	"ingame_menu":	preload("res://scenes/ingame_menu.tscn")
}

@export var scene_dict = {
	"tilemap":	"res://scenes/tile_map_layer.tscn",
	"scene_loader":	"res://scenes/scene_loader.tscn",
	"player":	"res://scenes/player.tscn",
	"main_menu":	"res://scenes/main_menu.tscn",
	"items":	"res://scenes/item.tscn",
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

func _ready():
	var main_scene = load(scene_dict.main_menu)
	#var main_scene = preloads.main_menu.instantiate()
	#self.add_child(main_scene)
	
	

#func drop(item, start, end):

func load_level(scene):
	get_tree().change_scene_to_file(scene_dict[scene])
	

func _input(event):
	if event.is_action_pressed("esc"):
		toggle.ingame_menu = !toggle.ingame_menu
		if toggle.ingame_menu:
			load_level("ingame_menu")
		else:
			load_level("tilemap")
	if event.is_action_pressed("e"):
		get_tree().change_scene_to_file(scene_dict.inventory)
		
	
