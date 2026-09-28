extends CharacterBody2D

var speed: float = 300.0

func _physics_process(delta: float) -> void:
		var direction := Input.get_axis("move_up","move_down")
		velocity = Vector2(0, direction * speed)
		move_and_slide()
