extends Node

@onready var game_manager = %GameManager
@onready var counter = $UI/Label


var score = 0

func add_coin():
	counter.add_coin()

func add_score():
	score += 1
	print(score)
 
