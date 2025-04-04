extends Resource

class_name Save_res

@export var scene: String = ""
@export var missions: AllMissions = AllMissions.new()
@export var spells: Inv = Inv.new()
@export var current_potions: Array[InvItem] = [load("res://Items/spells/splash.tres"),load("res://Items/spells/splash.tres"),load("res://Items/spells/splash.tres")]
@export var current_spell: String = "splash"
@export var player_inv: Inv = Inv.new()
@export var coins: int
