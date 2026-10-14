extends Node2D

enum  Mode {NORMAL, DARK, SHRINK}

var current_mode: Mode = Mode.NORMAL

@onready var ball: CharacterBody2D = $Ball
@onready var left_paddle: CharacterBody2D = $LeftPaddle
@onready var right_paddle: CharacterBody2D = $RightPaddle
@onready var left_score_label: Label = $LeftScoreLabel
@onready var right_score_label: Label = $RightScoreLabel
@onready var score_sfx: AudioStreamPlayer = $ScoreSFX
@onready var darkness: CanvasModulate = $Darkness


func _ready() -> void:
	Global.changed.connect(uppdate_labels)
	uppdate_labels()

func _on_left_goal_body_entered(body: Node2D) -> void:
	if body == ball:
		Global.add_score_right()
		score_sfx.play()
		new_round()
		ball.reset()
		print ("score")

func _on_right_goal_body_entered(body: Node2D) -> void:
	if body == ball:
		Global.add_score_left()
		score_sfx.play()
		new_round()
		ball.reset()
		
		print ("score")

func uppdate_labels():
	left_score_label.text = str(Global.left_score)
	right_score_label.text = str(Global.right_score)

func set_mode_shrink():
	left_paddle.shrink()
	right_paddle.shrink()

func set_mode_dark(on: bool):
	darkness.visible = on
	ball.set_light(on)

func pick_random_mode():
	var options = Mode.values()
	options.erase(current_mode)
	current_mode = options.pick_random()
	apply_mode(current_mode)

func apply_mode(mode: Mode):
	set_mode_dark(mode == Mode.DARK)
	var shrink = mode == Mode.SHRINK
	if shrink:
		set_mode_shrink()
	else:
		left_paddle.reset_size()
		right_paddle.reset_size()

func new_round():
	left_paddle.reset_position()
	right_paddle.reset_position()
	pick_random_mode()
