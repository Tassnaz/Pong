extends Node2D

@onready var ball: CharacterBody2D = $Ball
@onready var left_paddle: CharacterBody2D = $LeftPaddle
@onready var right_paddle: CharacterBody2D = $RightPaddle
@onready var left_score_label: Label = $LeftScoreLabel
@onready var right_score_label: Label = $RightScoreLabel
@onready var score_sfx: AudioStreamPlayer = $ScoreSFX

func _ready() -> void:
	Global.changed.connect(uppdate_labels)
	uppdate_labels()

func _on_left_goal_body_entered(body: Node2D) -> void:
	if body == ball:
		Global.add_score_right()
		ball.reset()
		print ("score")
		score_sfx.play()
		new_round()

func _on_right_goal_body_entered(body: Node2D) -> void:
	if body == ball:
		Global.add_score_left()
		ball.reset()
		print ("score")
		score_sfx.play()
		new_round()

func uppdate_labels():
	left_score_label.text = str(Global.left_score)
	right_score_label.text = str(Global.right_score)

func shrink_paddles():
	left_paddle.shrink()
	right_paddle.shrink()

func new_round():
	shrink_paddles()
