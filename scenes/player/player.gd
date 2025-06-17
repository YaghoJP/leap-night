extends CharacterBody2D
class_name Player


@export_category("Variables")
@export var max_speed: float = 180.0
@export var jump_force: float = 450
@export var max_jumps: int = 2
@export var gravity: float = 1600

@export_category("Objects")
@export var player_start_pos: Marker2D
@export var anim_sprite: AnimatedSprite2D
@export var ray_cast: RayCast2D

var jumps_left: int
var move_direction: int = 1
var can_move: bool = true

func _ready() -> void:
	jumps_left = max_jumps
	
func _physics_process(delta: float) -> void:
	
	if not can_move:
		return
		
	handle_movement()
	handle_gravity(delta)
	handle_wall_collision()
	handle_jump_input()
	
	move_and_slide()

func handle_jump_input() -> void:
	if not Input.is_action_just_pressed("tap"):
		return
	
	if ray_cast.is_colliding():
		change_direction()
			
	jump()
	
func jump() -> void:
	if jumps_left <= 0:
		return
		
	SoundManager.play_jump()
	
	velocity.y = -jump_force
	jumps_left -= 1
	
	if jumps_left <= 0:
		anim_sprite.play("double_jump")
	else:
		anim_sprite.play("jump")
	
func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_wall_collision() -> void:
	if not ray_cast.is_colliding():
		return
	
	velocity.y = 50
	jumps_left = max_jumps
	anim_sprite.play("fall")
	
	if is_on_floor():
		change_direction()
		
func change_direction() -> void:
	move_direction *= -1
	scale.x *= -1
	
func handle_movement() ->void:
	velocity.x = move_direction * max_speed
	if is_on_floor():
		anim_sprite.play("run")
		jumps_left = max_jumps
		
func player_dead() -> void:
	can_move = false
	velocity = Vector2.ZERO
	
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self, "global_position", player_start_pos.position  , 1)
	
	anim_sprite.play("dead")


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "dead":
		self.global_position = player_start_pos.global_position
		anim_sprite.play("respawn")
		return
		
	if anim_sprite.animation == "respawn":
		anim_sprite.play("run")
		can_move = true
		return
