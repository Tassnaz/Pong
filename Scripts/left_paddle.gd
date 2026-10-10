extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed: float

func _physics_process(delta: float) -> void:
		var direction := Input.get_axis("move_up","move_down")
		velocity = Vector2(0, direction * speed)
		move_and_slide()

func shrink():
	animation_player.play("shrink")
