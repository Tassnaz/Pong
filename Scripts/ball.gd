extends CharacterBody2D

@onready var paddle_hit_sfx: AudioStreamPlayer2D = $PaddleHitSFX
@onready var wall_hit_sfx: AudioStreamPlayer2D = $WallHitSFX
@onready var hit_particles: CPUParticles2D = $HitParticles
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_light_2d: PointLight2D = $PointLight2D


@export var speed: float = 400.0
@export var launch_delay: float = 1.0

func _ready() -> void:
	launch()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		spawn_particles(collision)
		var collider = collision.get_collider()
		if collider.is_in_group("paddle"):
			speed += 25
			var screen_mid = get_viewport_rect().size.x / 2
			var dir_x = 1.0 if collider.global_position.x < screen_mid else -1.0
			
			var paddle_shape = collider.get_node("CollisionShape2D").shape
			var half_w = paddle_shape.size.x / 2
			var half_h = paddle_shape.size.y / 2
			var radius = $CollisionShape2D.shape.radius
			
			global_position.x = collider.global_position.x + dir_x * (half_w + radius + 1.0)
			
			var hit = clamp((global_position.y - collider.global_position.y) / half_h, -1.0, 1.0)
			
			velocity = Vector2(dir_x, hit * 0.75).normalized() * speed
			
			paddle_hit_sfx.play()
			print ("paddle hit")
			
			
		elif collider.is_in_group("wall"):
			velocity = velocity.bounce(collision.get_normal())
			wall_hit_sfx.play()
			print ("wall hit")
			
		else:
			velocity = velocity.bounce(collision.get_normal())

func launch():
	velocity = Vector2.ZERO
	await get_tree().create_timer(launch_delay).timeout
	var angle = randf_range(-PI / 4, PI / 4)
	var dir = Vector2.RIGHT.rotated(angle)
	if randf() < 0.5:
		dir.x *= -1
	velocity = dir * speed

func reset():
	global_position = get_viewport_rect().size / 2
	speed = 400
	launch()

func spawn_particles(collision):
	hit_particles.global_position = collision.get_position()
	hit_particles.rotation = collision.get_normal().angle()
	hit_particles.restart()

func set_light(on: bool):
	point_light_2d.visible = on
