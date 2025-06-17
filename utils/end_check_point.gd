extends Area2D
class_name EndCheckPoint


func _on_body_entered(body: Node2D) -> void:
	SoundManager.play_hit()
	EventManager.on_game_won.emit()
