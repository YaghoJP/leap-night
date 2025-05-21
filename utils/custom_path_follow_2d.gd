extends PathFollow2D
class_name CustomPathFollow

@export_category("Variables")
@export var move_speed: float = 0.5

var direction: int = 1
var can_move: bool = true

func _process(delta: float) -> void:
	if not can_move:
		return

	progress_ratio += move_speed * delta * direction
	
	if progress_ratio >= 1:
		direction = -1
	if progress_ratio <= 0:
		direction = 1
