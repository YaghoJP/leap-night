extends Node2D
class_name Game

@export_category("Objects")
@export var player: Player
@export var player_start_position: Marker2D
@export var label_score: Label
@export var panel_won: Panel

var points: int = 0

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead)
	EventManager.on_fruit_collected.connect(_on_fruit_collected)
	EventManager.on_checkpoint_rached.connect(_on_checkpoint_rached)
	EventManager.on_game_won.connect(_on_game_won)
	
func _on_game_won()->void:
	panel_won.show()
	
func _on_player_dead() -> void:
	player.player_dead()
	
func _on_fruit_collected() -> void:  
	points += 1
	label_score.text = str(points)

func _on_checkpoint_rached(pos: Vector2) -> void:
	player.player_start_pos.position = pos


func _on_play_button_pressed() -> void:
	get_tree().reload_current_scene()
