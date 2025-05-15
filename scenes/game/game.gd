extends Node2D
class_name Game

@export_category("Objects")
@export var player: Player

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead)
	
	
func _on_player_dead() -> void:
	player.player_dead()
	
