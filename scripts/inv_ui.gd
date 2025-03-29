extends NinePatchRect

@onready var itemlist = $VBoxContainer/ItemList
@onready var player_inv = preload("res://Items/player_inventory.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#print(itemlist.get_item_))


func _on_draw() -> void:
	var text: String
	#print(player_inv.items.keys())
	for index in itemlist.get_item_count():
		text = itemlist.get_item_text(index)
		print(text, "  ", player_inv.items[text.to_lower()].quantity)
		
		itemlist.set_item_text(index, text + " - " + str(player_inv.items[text.to_lower()].quantity))
		#item.text += " - "+str(player_inv.items[item.text].quantity)
