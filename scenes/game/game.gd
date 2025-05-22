extends Node2D
class_name Game

@export_category("Objects")
@export var player: Player
@export var player_start_position: Marker2D

var points: int = 0

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead)
	EventManager.on_fruit_collected.connect(_on_fruit_collected)
	
func _on_player_dead() -> void:
	player.player_dead()
	
func _on_fruit_collected() -> void:
	points += 1	
