extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


@export var speed: float
@export var margin: float = 0.0

var start_x: float

func _ready() -> void:
	start_x = global_position.x

func _physics_process(delta: float) -> void:
		var direction := Input.get_axis("move_up","move_down")
		velocity = Vector2(0, direction * speed)
		move_and_slide()
		
		#var half = collision_shape_2d.shape.size.y / 2
		#var screen_h = get_viewport_rect().size.y
		#global_position.y = clamp(global_position.y, half + margin, screen_h - half - margin)
		#global_position.x = start_x

func shrink():
	animation_player.play("shrink")
