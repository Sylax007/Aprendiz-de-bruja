extends Resource

class_name InvItem

@export var texture: Texture2D
@export var drinkable = false
@export var spell = false
@export var name: String = ""
@export var quantity: int = 0
@export var price: int = 0
@export var damage: int = 0
@export var cooldown: float = 0.0
@export var temperature: int
@export var speed: int
@export var duration: float
@export var types: Dictionary[String, float]
@export var description: String
@export var recipe: Dictionary[InvItem,int]
