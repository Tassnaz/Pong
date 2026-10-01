extends CharacterBody2D

@export var speed: float = 400.0

func _ready() -> void:
	launch()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("paddle"):
			speed += 25
			
			var hit = clamp((global_position.y - collider.global_position.y) / 50.0, -1.0, 1.0)
			var dir = Vector2(-sign(velocity.x), hit * 0.75).normalized()
			velocity = dir * speed
		else:
			velocity = velocity.bounce(collision.get_normal())
			
func launch():
	var angle = randf_range(-PI / 4, PI / 4)
	var dir = Vector2.RIGHT.rotated(angle)
	if randf() < 0.5:
		dir.x *= -1
	velocity = dir * speed
	
