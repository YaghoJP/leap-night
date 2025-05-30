extends CharacterBody2D
class_name EnemyRino

@export_category("Objects")
@export var ray_cast_player: RayCast2D
@export var anim_sprite: AnimatedSprite2D
@export var ray_cast_wall: RayCast2D

@export_category("Variables")
@export var ray_length: int = 130
@export var move_speed: float = 150.0

var direction: int = 1
var can_move: bool = false
var defeated: bool = false

func _ready() -> void:
	ray_cast_player.target_position.x = -ray_length

func _process(delta: float) -> void:
	
	if ray_cast_player.is_colliding():
		can_move = true
		
	if not can_move: 
		return

	if can_move:
		velocity.x = direction * move_speed
		anim_sprite.play("run")
		move_and_slide()
	
	if ray_cast_wall.is_colliding():
		can_move = false
		direction *= -1
		print(direction)
		anim_sprite.play("hit_wall")
		
		
func rotateSprite() -> void:
	anim_sprite.scale.x = direction
	ray_cast_player.scale.x = direction
	ray_cast_wall.scale.x = direction
	
	
func _on_top_area_body_entered(body: Node2D) -> void:
	if body is not Player: return
	defeated = true
	
	anim_sprite.play("hit")

func _on_bottom_area_body_entered(body: Node2D) -> void:
	if defeated:
		return

	EventManager.on_player_dead.emit()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "hit":
		queue_free()
		return
		
	if anim_sprite.animation == "hit_wall":
		rotateSprite()
		anim_sprite.play("idle")
		return
