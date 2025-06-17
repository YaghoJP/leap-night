extends Area2D
class_name Spikes


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
		
	SoundManager.play_hit()
	EventManager.on_player_dead.emit()
