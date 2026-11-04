extends Control

@onready var winner_label: RichTextLabel = $PanelContainer/VBoxContainer/WinnerLabel

func _ready() -> void:
	winner_label.text = str(Global.winner) + " Wins"

func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	reset_score()

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	reset_score()

func reset_score():
	Global.left_score = 0
	Global.right_score = 0
