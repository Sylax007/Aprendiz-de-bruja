extends Control

@onready var texture = $MarginContainer/HBoxContainer/Panel/VBoxContainer/HBoxContainer/TextureRect
@onready var title = $MarginContainer/HBoxContainer/Panel/VBoxContainer/HBoxContainer/Mission_title
@onready var description = $MarginContainer/HBoxContainer/Panel/VBoxContainer/RichTextLabel
@onready var reward = $MarginContainer/HBoxContainer/Panel/VBoxContainer/reward
@onready var itemlist = $MarginContainer/HBoxContainer/ItemList
@onready var missions = preload("res://missions/All_missions.tres")

# Called when the node enters the scene tree for the first time.
func update_items(index):
	var text = itemlist.get_item_text(index)
	var mission
	for mis in missions.items.keys():
		if mis.name.to_lower() == text.to_lower():
			mission = mis
			description.text = mission.description
			reward.text = "Reward: " + str(mission.reward)
			break
	title.text = text


func _ready() -> void:
	itemlist.select(0)
	update_items(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_list_item_selected(index: int) -> void:
	update_items(index)


func _on_item_list_draw() -> void:
	var index: int
	print("missions: ",global.saving.missions)
	for mission in global.saving.missions.items.keys():
		index = itemlist.add_item(mission.name)
		update_items(index)
		if not global.saving.missions.items[mission]:
			itemlist.set_item_disabled(index, true)
