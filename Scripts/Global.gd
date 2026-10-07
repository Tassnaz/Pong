extends Node

signal changed

var left_score: int = 0
var right_score: int = 0

func add_score_left():
	left_score += 1
	changed.emit()

func add_score_right():
	right_score += 1
	changed.emit()
