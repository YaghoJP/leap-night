extends Area2D
class_name SpikeBall

@export_category("Variables")
@export var move_speed: float = 3.5
@export var max_rotation_angle: float = 40

func _process(delta: float) -> void:
	var rotation_factor = sin(Time.get_ticks_msec() / 1000.0 * move_speed)
	rotation_degrees = rotation_factor * max_rotation_angle


func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	
	SoundManager.play_hit()
	EventManager.on_player_dead.emit()
	
