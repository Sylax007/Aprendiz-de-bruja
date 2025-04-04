extends Control

@onready var slot_scene = preload("res://scenes/inv_slot.tscn")
@onready var potions_inv = preload("res://Items/potions/all_potions.tres")
@onready var player_inv = global.saving.player_inv
@onready var potion_list = $MarginContainer/HBoxContainer/potion_container/potion_list
@onready var ingredient_list = $MarginContainer/HBoxContainer/right_container/Inv_UI
@onready var crafting_table = $MarginContainer/HBoxContainer/right_container/crafting_table_container/crafting_table
@onready var slot1 = $MarginContainer/HBoxContainer/right_container/crafting_table_container/crafting_table/item_grid/inv_slot1
@onready var slot2 = $MarginContainer/HBoxContainer/right_container/crafting_table_container/crafting_table/item_grid/inv_slot2
var slot3 = null
var item_selected = 0

func _ready():
	potion_list.select(0)
	update_items(0)


func update_items(index):
	if slot3:
		slot3.queue_free()
	#var item = potion_list.get_item_at_position(index)
	var text = potion_list.get_item_text(index)
	crafting_table.get_node("potion_name").text = text
	crafting_table.get_node("potion_img").texture = potion_list.get_item_icon(index)
	crafting_table.get_node("RichTextLabel").text = potions_inv.items[text.to_lower()].description
	
	slot1.slot.sprite.texture = potions_inv.items[text.to_lower()].recipe.keys()[0].texture
	slot1.slot.name_label.text = potions_inv.items[text.to_lower()].recipe.keys()[0].name
	slot1.slot.quantity_label.text = str(potions_inv.items[text.to_lower()].recipe.values()[0])
	#print(potions_inv.items[text.to_lower()].recipe.keys()[0].name)
	slot2.slot.sprite.texture = potions_inv.items[text.to_lower()].recipe.keys()[1].texture
	slot2.slot.name_label.text = potions_inv.items[text.to_lower()].recipe.keys()[1].name
	slot2.slot.quantity_label.text = str(potions_inv.items[text.to_lower()].recipe.values()[1])
	if potions_inv.items[text.to_lower()].recipe.values().size() >= 3:
		slot3 = slot_scene.instantiate()
		slot2.add_sibling(slot3)
		slot3.slot.sprite.texture = potions_inv.items[text.to_lower()].recipe.keys()[2].texture
		slot3.slot.name_label.text = potions_inv.items[text.to_lower()].recipe.keys()[2].name
		slot3.slot.quantity_label.text = str(potions_inv.items[text.to_lower()].recipe.values()[2])
	item_selected = index
	

func _on_potion_list_item_selected(index: int) -> void:
	update_items(index)

func _on_craft_button_pressed() -> void:
	var text = potion_list.get_item_text(item_selected)
	var player_quantity = 0
	var item1 = null
	var quantity1 = 0
	var first_accepted = false
	for item in potions_inv.items[text.to_lower()].recipe.keys():
		player_quantity = player_inv.items[text.to_lower()].quantity
		if player_quantity >= item.quantity and not first_accepted:
			item1 = item
			quantity1 = potions_inv.items[text.to_lower()].recipe[item]
			first_accepted = true
		if player_quantity >= item.quantity and first_accepted:
			player_inv.items[item.name.to_lower()].quantity -= potions_inv.items[text.to_lower()].recipe[item]
			player_inv.items[item1.name.to_lower()].quantity -= potions_inv.items[text.to_lower()].recipe[item1]
			player_inv.items[text.to_lower()] = potions_inv.items[text.to_lower()]
			player_inv.items[text.to_lower()].quantity += 1 
