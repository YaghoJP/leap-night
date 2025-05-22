extends CharacterBody2D
class_name BlueBird

@export_category("Objects")
@export var path: CustomPathFollow
@export var anim_sprite: AnimatedSprite2D

var defeated: bool = false

func _process(delta: float) -> void:
	anim_sprite.flip_h = path.direction == 1

func _on_top_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	
	defeated = true
	anim_sprite.play("hit")
	path.can_move = false
	body.velocity.y = -250

func _on_bottom_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	
	if defeated:
		return
	
	EventManager.on_player_dead.emit()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "hit":
		queue_free()
