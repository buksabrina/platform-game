extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_level(level):
	$level.text = "level: " + str(level)

func victory():
	$level.text = "You Win!"

func game_over():
	$level.text = "You lose! GAME OVER"
