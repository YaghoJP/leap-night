extends Area2D
class_name Checkpoint

@export_category("Objects")
@export var anim_sprite: AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return
	anim_sprite.play("reached")
	EventManager.on_checkpoint_rached.emit(self.position)
