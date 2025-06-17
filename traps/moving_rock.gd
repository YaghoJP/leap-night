extends StaticBody2D
class_name MovingRock

@export_category("Variables")
@export var reset_time: float = 0.5
@export var move_distance: float = 95

@export_category("Objects")
@export var anim_sprite: AnimatedSprite2D

var start_position: Vector2

func _ready() -> void:
	start_position = global_position

func move_bottom() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position:y", start_position.y + move_distance, 0.5)
	tween.tween_interval(reset_time)
	tween.tween_property(self, "global_position:y", start_position.y, 0.5)

func _on_action_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	move_bottom()

func _on_kill_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	
	SoundManager.play_hit()
	EventManager.on_player_dead.emit()
