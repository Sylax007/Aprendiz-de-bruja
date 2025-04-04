extends Control

var all_items = Inv.new()
var current_selection: int = 0

@onready var bag_ui = $MarginContainer/HBoxContainer/NinePatchRect
@onready var texture = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/TextureRect
@onready var title = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/title
@onready var price = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/GridContainer/price
@onready var damage = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/GridContainer/damage
@onready var throwable = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/GridContainer/throwable
@onready var description = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/description
@onready var buy_button = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/Button
@onready var current_spells = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/ItemList
@onready var itemlist = $MarginContainer/HBoxContainer/ItemList
@onready var coins = $MarginContainer/HBoxContainer/VBoxContainer/Panel/MarginContainer/BoxContainer/HBoxContainer/coins

@onready var all_spells = preload("res://Items/spells/all_spells.tres")
@onready var all_potions = preload("res://Items/potions/all_potions.tres")

func update_items(index, items = all_items):
	var text = itemlist.get_item_text(index)
	texture.texture = itemlist.get_item_icon(index)
	title.text = text
	description.text = "Description: "+items.items[text.to_lower()].description
	if items.items[text.to_lower()].spell:
		price.text = "Price: " + str(items.items[text.to_lower()].price * (items.items[text.to_lower()].quantity + 1)**1.05)
	else:
		price.text = "Price: " + str(items.items[text.to_lower()].price)
	if global.saving:
		coins.text = str(global.saving.coins)
	if items.items[text.to_lower()].drinkable:
		throwable.text = "Drinkable"
	else: 
		throwable.text = "Throwable"
	

func add_items(list):
	for item in list.items.keys():
		itemlist.add_item(list.items[item].name,list.items[item].texture)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	all_items.items.merge(all_spells.items)
	all_items.items.merge(all_potions.items)
	add_items(all_items)
	#add_items(all_spells)
	update_items(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_item_list_item_selected(index: int) -> void:
	update_items(index)


#func _on_item_list_draw() -> void:
	#add_items(all_spells)
	#add_items(all_potions)
