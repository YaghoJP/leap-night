extends CharacterBody2D
class_name Player


@export_category("Variables")
@export var max_speed: float = 180.0
@export var jump_force: float = 450
@export var max_jumps: int = 2
@export var gravity: float = 1600

@export_category("Objects")
@export var anim_sprite: AnimatedSprite2D
@export var ray_cast: RayCast2D
