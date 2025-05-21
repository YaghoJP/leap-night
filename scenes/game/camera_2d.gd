extends Camera2D
class_name Camera

@export_category("Objects")
@export var player: Player


func _process(delta: float) -> void:
	var target_pos = player.global_position.y
	var current_pos = global_position.y
	var new_pos = lerpf(current_pos, target_pos, 5*delta)
	global_position.y = new_pos
