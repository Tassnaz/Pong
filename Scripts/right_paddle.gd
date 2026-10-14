extends CharacterBody2D

var start_pos: Vector2

@export var speed: float
@export var margin: float = 0.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	start_pos = global_position

func _physics_process(delta: float) -> void:
		var direction := Input.get_axis("move_up_p2","move_down_p2")
		velocity = Vector2(0, direction * speed)
		move_and_slide()
		
		#var half = collision_shape_2d.shape.size.y / 2
		#var screen_h = get_viewport_rect().size.y
		#global_position.y = clamp(global_position.y, half + margin, screen_h - half - margin)
		#global_position.x = start_x

func shrink():
	animation_player.play("shrink")

func reset_size():
	animation_player.play_backwards("shrink")

func reset_position():
	global_position = start_pos
