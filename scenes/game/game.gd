extends Node2D
class_name Game

@export_category("Objects")
@export var player: Player
@export var player_start_position: Marker2D

var points: int = 0

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead)
	EventManager.on_fruit_collected.connect(_on_fruit_collected)
	EventManager.on_checkpoint_rached.connect(_on_checkpoint_rached)
	
func _on_player_dead() -> void:
	player.player_dead()
	
func _on_fruit_collected() -> void:  
	points += 1

func _on_checkpoint_rached(pos: Vector2) -> void:
	player.player_start_pos.position = pos
