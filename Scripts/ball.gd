extends CharacterBody2D

@onready var paddle_hit_sfx: AudioStreamPlayer2D = $PaddleHitSFX
@onready var wall_hit_sfx: AudioStreamPlayer2D = $WallHitSFX
@onready var hit_particles: CPUParticles2D = $HitParticles
@onready var animation_player: AnimationPlayer = $AnimationPlayer



@export var speed: float = 400.0
@export var launch_delay: float = 1.0
@export var half_paddle_height: float = 159.0

func _ready() -> void:
	launch()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		spawn_particles(collision)
		var collider = collision.get_collider()
		if collider.is_in_group("paddle"):
			speed += 25
			paddle_hit_sfx.play()
			print ("paddle hit")
			
			var hit = clamp((global_position.y - collider.global_position.y) / half_paddle_height, -1.0, 1.0)
			var dir = Vector2(-sign(velocity.x), hit * 0.75).normalized()
			velocity = dir * speed
			
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
	Global.shrink.emit()
	launch()

func spawn_particles(collision):
	hit_particles.global_position = collision.get_position()
	hit_particles.rotation = collision.get_normal().angle()
	hit_particles.restart()

func divide_paddle_height():
	animation_player.play("half_paddle_height")
