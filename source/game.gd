extends Node2D





export var current_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var level := load ("res://source/level" + str(current_level) + ".tscn")
	var scene = level.instance()
	add_child (scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
