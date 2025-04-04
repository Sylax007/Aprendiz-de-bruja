extends Node

@onready var root_path = get_tree().root



#@onready var missions = preload("res://missions/missions.tres")
#@onready var player_inv = preload("res://Items/player_inventory.tres")
#@onready var current_scene = preload()
#@onready var missions = preload()
var camera_box
var save_path = "res://saves/save"
var saving: Save_res = new_save()
var timer: Timer = Timer.new()
var audio_stream: AudioStreamMP3 = AudioStreamMP3.new()

var enemy_ids: Array
var current_song = "res://assets/Soundtracks/starting menu.mp3"
var player_node
var timer_slow = null
var current_scene = null
var current_ui = null
var is_dragging = false
var is_being_assigned = false
var has_shape_entered = null
var collected_slot = InvItem.new()
var screen_showing
var toggled

var player = null

const audio_files = {
	"cementery": "res://assets/Soundtracks/cemetery map.mp3",
	"forest_corr": "res://assets/Soundtracks/creepy forest map.mp3",
	"dragon_fight": "res://assets/Soundtracks/dragon fight.mp3",
	"forest": "res://assets/Soundtracks/forest map.mp3",
	"inventory_menu": "res://assets/Soundtracks/main menu.mp3",
	"secret_graveyard": "res://assets/Soundtracks/secret graveyard map.mp3",
	"shop": "res://assets/Soundtracks/Shop.mp3",
	"snow": "res://assets/Soundtracks/snowy forest map.mp3",
	"main_menu": "res://assets/Soundtracks/starting menu.mp3",
	'cabin': "res://assets/Soundtracks/main menu.mp3",
	"shop_menu": "res://assets/Soundtracks/main menu.mp3",
	"ingame_menu": "res://assets/Soundtracks/main menu.mp3",
	"mission_menu": "res://assets/Soundtracks/main menu.mp3"
}

const colors = {
	"green": "ff9d0e",
	"red": "db0000",
	"blue": "2e5cdb",
	"yellow": "d9a100",
	"gold": "ff9d0e",
	"fire": "d64f00"
}

var save = {
	"position": Vector2.ZERO,
	"coins": 0,
	"inventory": Inv
}


const item_list = {
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

const enemies = {
	"green bunnyslime": ["green droplet", "blue droplet", "red droplet", "orange droplet", "yellow droplet", "purple droplet"],
	"blue bunnyslime": ["blue droplet"],
	"red bunnyslime": ["red droplet"],
	"orange bunnyslime": ["orange droplet"],
	"yellow bunnyslime": ["yellow droplet"],
	"purple bunnyslime": ["purple droplet", "bottled soul", "mandrake"],
	"white skeleton": ["creepy eye","forbidden meat","phantom cloth"],
	"gold skeleton": ["forbidden meat","creepy eye"],
	"blue frog": ["phantom cloth", "forbidden meat"],
	"fire frog": ["bottled soul"],
	"dragon": [""]
}


const scene_dict = {
	"bag_ui": "res://scenes/bag_ui.tscn",
	"detection_area": "res://scenes/detection_area.tscn",
	"dialogue_box": "res://scenes/dialogue_box.tscn",
	"enemy": "res://scenes/enemy.tscn",
	"ingame_menu":	"res://scenes/ingame_menu.tscn",
	"inv_ui":	"res://scenes/inv_ui.tscn",
	"inventory_menu":	"res://scenes/inventory.tscn",
	"item":	"res://scenes/item.tscn",
	"main_menu":	"res://scenes/main_menu.tscn",
	"player":	"res://scenes/player.tscn",
	"reflection": "res://scenes/reflection.tscn",
	"scene_loader":	"res://scenes/scene_loader.tscn",
	"slot": "res://scenes/inv_slot.tscn",
	"spell": "res://scenes/spells.tscn",
	"tilemap":	"res://scenes/tile_map_layer.tscn",
	"wall": "res://scenes/wall_scene.tscn",
	"shop_menu": "res://scenes/shop_menu.tscn",
	"mission_menu": "res://scenes/mission_menu.tscn",
	"status_menu": "res://scenes/status_menu.tscn"
}

const maps = {
	"default_tilemap": "res://scenes/tile_map_layer.tscn",
	"forest": "res://scenes/forest_tilemap.tscn",
	"forest_corr": "res://scenes/island_tilemap_corr.tscn",
	"valley": "res://scenes/valley_tilemap.tscn",
	"cementery": "res://scenes/cementery_scene.tscn",
	"cabin": "res://scenes/cabin_scene.tscn"
}
var toggle = {
	"tilemap": false,
	"scene_loader": false,
	"player": false,
	"main_menu": false,
	"item_ui": false,
	"inv_ui": false,
	"inventory_menu": false,
	"ingame_menu": false,
	"mission_menu": false,
	"shop_menu": false,
	"status_menu": false
}

const res_dict = {
	"player_inventory": "res://Items/player_inventory.tres"
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
	"player_inventory": preload("res://Items/player_inventory.tres"),
	"missions": preload("res://missions/missions.tres"),
	"all_missions": preload("res://missions/All_missions.tres")
}

#region Create an empty inventory
func empty_inv():
	var empty = Inv.new()
	for item_name in preloads.inv.items.keys():
		empty.items[item_name] = InvItem.new()
		empty.items[item_name].texture = preloads.inv.items[item_name].texture
		empty.items[item_name].name = preloads.inv.items[item_name].name
		empty.items[item_name].price = preloads.inv.items[item_name].price
		empty.items[item_name].damage = preloads.inv.items[item_name].damage
		empty.items[item_name].cooldown = preloads.inv.items[item_name].cooldown
		empty.items[item_name].description = preloads.inv.items[item_name].description
		empty.items[item_name].recipe = preloads.inv.items[item_name].recipe
		#empty[some_inv[index].name.to_lower()] = some_inv[index]
	return empty
#endregion

#region Slows the time based on the time scale, and duration in realtime seconds
func time_slow(time_scale, duration, rt_duration = true):
	var time_calc
	if rt_duration:
		time_calc = time_scale * duration
	else:
		time_calc = duration
	Engine.time_scale = time_scale
	timer_slow = await get_tree().create_timer(time_calc).timeout
	Engine.time_scale = 1.0
#endregion

@onready var empty_inventory = empty_inv()

#func _ready():
	#var main_scene = load(scene_dict.main_menu)
	#var main_scene = preloads.main_menu.instantiate()
	#self.add_child(main_scene)
	

func inv_generator(list, max_loot, prob = 30):
	var inv_generate = {"items": {}}
	#var empty_inventory = empty_inv()
	for val in empty_inventory.items.keys():
		var rand_val = randi_range(0,100)
		if val in list and rand_val >= 30:
			inv_generate.items[val] = empty_inventory.items[val]
			inv_generate.items[val]["quantity"] = randi_range(0, max_loot)
	return inv_generate


func fade_in(node: CanvasItem, duration: float = 1.0):
	var tween = get_tree().create_tween()
	#node.modulate.a = 0
	tween.tween_property(node, "modulate:a", 1, duration)
	await get_tree().create_timer(duration).timeout
	#tween.queue_free()

func fade_out(node, duration: float = 1.0):
	var tween = get_tree().create_tween()
	node.modulate.a = 1
	tween.tween_property(node, "modulate:a", 0, duration)
	#await get_tree().creachange_song():
	var file = FileAccess.open(global.current_song, FileAccess.READ)
	var buffer = file.get_buffer(file.get_len())
	var stream = AudioStreamMP3.new()
	stream.data = buffer
	#audio_stream.set_playing(true)
	current_song = global.current_songte_timer(duration).timeout
	#tween.queue_free()


func saving_function(path = save_path, obj: Save_res = null, overwrite = false, id = 0, extension = ".save"):
	var file_path: String
	if overwrite:
		file_path = path + str(id) + extension
	else:
		file_path = check_files(path,id,extension)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_var(obj)

func loading_function(path = save_path,full_path = false,id = 0,extension = ".save"):
	if full_path:
		var file = FileAccess.open(path, FileAccess.READ)
		return file.get_var()
	elif FileAccess.file_exists(path+str(id)+extension):
		var file = FileAccess.open(path+str(id)+extension, FileAccess.READ)
		print(file.get_var(true))
		return file.get_var()
	return Save_res.new()

func check_files(path = save_path, overwrite = false, id = 0, extension = ".tres"):
	while FileAccess.file_exists(path+str(id)+extension) and not overwrite:
		id += 1
	return path+str(id)+extension
	
func save_game(path: String, overwrite = false):
	if not overwrite:
		path = check_files()
	ResourceSaver.save(saving, path)

func load_game(path):
	saving = load(path)

func update_data():
	preloads.missions.items = saving.missions.items
	preloads.player_inventory.items = saving.player_inv.items


func display_ui(node_name, parent_node):
	for node in parent_node.get_children():
		#print("node is; ",node.get_path())
		node.queue_free()
	if timer_slow:
		timer_slow.stop()
	Engine.time_scale = 1
	if not toggle[node_name]:
		var new_node = load(scene_dict[node_name])
		new_node = new_node.instantiate()
		parent_node.add_child(new_node)
		#new_node.global_position = Vector2(100,0)
		time_slow(0.00001,10000, false)
		for val in toggle.keys():
			toggle[val] = false
	toggle[node_name] = not toggle[node_name]

func switch_scene(scene_name, urgent = false):
	#current_song = audio_files[scene_name]
	if urgent:
		get_tree().change_scene_to_file(maps[scene_name])
		return
	call_deferred("_deferred_switch_scene", scene_name)


func _deferred_switch_scene(scene_name):
	fade_out(current_scene,1)
	await get_tree().create_timer(1).timeout
	current_scene.queue_free()
	var s = load(scene_dict[scene_name])
	current_scene = s.instantiate()
	await get_tree().create_timer(1).timeout
	fade_in(current_scene,1)
	root_path.add_child(current_scene)


func toggling(scene_name: String = "cabin"):
	toggle[scene_name] = not toggle[scene_name]
	#print("toggling scene...")
	if toggle[scene_name]:
		#print("toggling working")
		switch_scene(scene_name)
	else:
		#print("toggling not working")
		switch_scene(scene_name)
		for val in toggle.keys():
			toggle[val] = false
		Engine.time_scale = 1
		
#func level_transition(level):
	#fade_out(current_scene,1)
	#await get_tree().create_timer(1).timeout
	#switch_scene(level)
	#fade_in(current_scene,1)

func new_save():
	var save_var = Save_res.new()
	save_var.missions.items[load("res://missions/mission1.tres")] = false
	return save_var

var _timer_timeout = func(path):
	save_game(save_path, true)

func _ready():
	#ResourceSaver.save(Save_res.new(), save_path+"0.tres")
	#saving_function(save_path, Save_res.new())
	#saving = loading_function(save_path)
	#print("Saving: ",saving)
	
	timer.wait_time = 10
	timer.one_shot = false
	timer.connect("timeout", _timer_timeout.bind(check_files(save_path)))
	timer.start()
	print("dialogues: ",dialogues)
#

func spawner(obj,spawn_number: int, level_enemies: Array,rand_coords: Vector2) -> void:
	for i in range(spawn_number):
		#print("spawning")
		#rand_coords = Vector2(randi()%200, randi()%200)
		var enemy = preloads.enemy.instantiate()
		enemy.random_enemy_generator(level_enemies)
		#global.enemy_ids += [enemy.get_instance_id()]
		obj.add_child(enemy)

var dialogues = JSON.parse_string("""[{
  "scene": "Beginning",
  "dialogue": [
	{
	  "character": "Narrator",	
	  "text": "In our world, for ages past, apprentice witches acquired the skills necessary to become a full-fledged witch through hard work and learning all kinds of potions and spells... And that's why..."
	}
  ]
},
{
  "scene": "Main Menu",
  "dialogue": [
	{
	  "character": "Pera",
	  "expression": "smile",
	  "text": "And that's why I, Pera, have decided to open my potion shop! Well... Or that's the idea, but no customers have arrived yet... Sigh"
	},
	{
	  "character": "Pera",
	  "expression": "determined",
	  "text": "No! Don't get discouraged! It's still too early, I'm sure a customer will arrive, right... now!"
	}
  ]
},
{
  "scene": "Customer Arrives",
  "dialogue": [
	{
	  "character": "Pera",
	  "expression": "surprised",
	  "text": "EEEEEK!"
	},
	{
	  "character": "Old Man",
	  "text": "UOOOOHH!"
	},
	{
	  "character": "Pera",
	  "expression": "sad",
	  "text": "..."$MarginContainer/HBoxContainer/Panel/VBoxContainer/Mission_title
	},
	{
	  "character": "Old Man",
	  "text": "Oh, I'm too old for these surprises..."
	},
	{
	  "character": "Pera",
	  "expression": "smile",
	  "text": "Ah! Sorry, sorry! You caught me off guard... Welcome to my potion shop! How can I help you?"
	},
	{
	  "character": "Old Man",
	  "text": "Well, you see, I've had back pain for a few days now, it's just the stuff of old age, you know. Now I have all the time in the world to rest and walk around as much as I want, but I also have a lot of ailments, ohoho! I just passed by this shop to see if there's a potion that can soothe this pain a bit..."
	},
	{
	  "character": "Pera",
	  "text": "Of course! You've come to the right place. Give me a moment and I'll prepare the perfect potion for you."
	}
  ]
},
{
  "scene": "Potion Preparation",
  "dialogue": [
	{
	  "character": "Pera",
	  "text": "Okay, let's prepare the perfect potion for our first customer!"
	},
	{
	  "character": "System",
	  "text": "(The potions section lights up.)"
	},
	{
	  "character": "Pera",
	  "text": "Here you can select any of the recipes I've learned."
	},
	{
	  "character": "System",
	  "text": "(When you click on a potion, the crafting section lights up, but the crafting button will remain dark)"
	},
	{
	  "character": "Pera",
	  "text": "Here you can read the potion's description to see if it's the one our customer really needs, as well as see the list of ingredients needed to make the potion."
	},
	{
	  "character": "System",
	  "text": "(Now the bag section lights up)"
	}
  ]
}]""")
