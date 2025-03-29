extends Control

@onready var slot_scene = preload("res://scenes/inv_slot.tscn")
@onready var potions_inv = preload("res://Items/potion_inv.tres")
@onready var potion_list = $MarginContainer/HBoxContainer/potion_container/potion_list
@onready var ingredient_list = $MarginContainer/HBoxContainer/right_container/Inv_UI
@onready var crafting_table = $MarginContainer/HBoxContainer/right_container/crafting_table_container/crafting_table
@onready var slot1 = $MarginContainer/HBoxContainer/right_container/crafting_table_container/crafting_table/item_grid/inv_slot1
@onready var slot2 = $MarginContainer/HBoxContainer/right_container/crafting_table_container/crafting_table/item_grid/inv_slot2
var slot3 = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_potion_list_item_selected(index: int) -> void:
	if slot3:
		slot3.queue_free()
	#var item = potion_list.get_item_at_position(index)
	var text = potion_list.get_item_text(index)
	crafting_table.get_node("potion_name").text = text
	crafting_table.get_node("potion_img").texture = potion_list.get_item_icon(index)
	crafting_table.get_node("RichTextLabel").text = potions_inv.items[text].description
	
	slot1.slot.sprite.texture = potions_inv.items[text].recipe.keys()[0].texture
	slot1.slot.name_label.text = potions_inv.items[text].recipe.keys()[0].name
	slot1.slot.quantity_label.text = str(potions_inv.items[text].recipe.values()[0])
	#print(potions_inv.items[text].recipe.keys()[0].name)
	slot2.slot.sprite.texture = potions_inv.items[text].recipe.keys()[1].texture
	slot2.slot.name_label.text = potions_inv.items[text].recipe.keys()[1].name
	slot2.slot.quantity_label.text = str(potions_inv.items[text].recipe.values()[1])
	if potions_inv.items[text].recipe.values().size() >= 3:
		slot3 = slot_scene.instantiate()
		slot2.add_sibling(slot3)
		slot3.slot.sprite.texture = potions_inv.items[text].recipe.keys()[2].texture
		slot3.slot.name_label.text = potions_inv.items[text].recipe.keys()[2].name
		slot3.slot.quantity_label.text = str(potions_inv.items[text].recipe.values()[2])
		
	#crafting_table.get_node("item_grid/inv_slot2")
	



func _on_craft_button_pressed() -> void:
	pass # Replace with function body.
