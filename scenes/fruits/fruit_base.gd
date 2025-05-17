extends Area2D
class_name Fruit

@export_category("Objects")
@export var anim_sprite: AnimatedSprite2D

var collected: bool = false


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	if collected:
		return
	
	collected = true
	anim_sprite.play("collect")
	EventManager.on_fruit_collected.emit()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "collect":
		queue_free()
