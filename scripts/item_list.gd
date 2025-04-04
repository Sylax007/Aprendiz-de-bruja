extends ItemList

@onready var main_node = $"../../../../../../.."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	select(0)
	main_node.current_selection = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_selected(index: int) -> void:
	main_node.current_selection = index
