extends Node

signal changed

var score_amount: int = 1
var left_score: int = 0
var right_score: int = 0
var score_to_win: int
var winner: String
var speed_increase: int = 25

func add_score_left():
	left_score += score_amount
	changed.emit()

func add_score_right():
	right_score += score_amount
	changed.emit()
	
func reset():
	left_score = 0
	right_score = 0
	changed.emit()
