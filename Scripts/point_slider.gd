extends Control

var target_score: int = 0

@onready var score_to_win_label: RichTextLabel = $PanelContainer/VBoxContainer/ScoreToWinLabel
@onready var h_slider: HSlider = $PanelContainer/VBoxContainer/HSlider

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	target_score = (h_slider.value)
	score_to_win_label.text = str(target_score)
	
func _on_play_button_pressed() -> void:
	Global.score_to_win = h_slider.value
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
