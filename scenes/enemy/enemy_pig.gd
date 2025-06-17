extends CharacterBody2D
class_name EnemyPig

@export_category("Variables")
@export var move_speed: float = 70.0

@export_category("Objects")
@export var anim_sprite: AnimatedSprite2D
@export var ray_cast: RayCast2D

var direction: int = 1
var can_move: bool = true
var defeated: bool = false
var can_flip = true

func _process(delta: float) -> void:
	if not can_move:
		return
	velocity.x = direction * move_speed 
	move_and_slide()
	
	if not ray_cast.is_colliding() and can_flip:
		can_flip = false
		direction *= -1
		anim_sprite.scale.x = direction
		ray_cast.scale.x = direction
		await  get_tree().create_timer(0.5).timeout.connect(set_can_flip)
		
func set_can_flip() ->void:
	can_flip = true

func _on_top_area_body_entered(body: Node2D) -> void:
	defeated = true
	can_move = false
	anim_sprite.play("hit")

	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_bottom_area_body_entered(body: Node2D) -> void:
	if defeated:
		return
	EventManager.on_player_dead.emit()
