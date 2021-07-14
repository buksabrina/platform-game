extends Node2D


export var current_level = 0

	
func next_level():
	current_level+= 1
	for node in get_children():
		node.queue_free ()
	var interstitial := load ("res://source/Interstitial.tscn")
	var interstitial_scene = interstitial.instance()
	interstitial_scene.set_level (current_level)
	add_child (interstitial_scene)
	var level := load ("res://source/level" + str(current_level) + ".tscn")
	if not level:
		interstitial_scene.victory()
	var timer := get_tree().create_timer(5)
	yield (timer,"timeout")
	var scene = level.instance()
	add_child(scene)
	interstitial_scene.queue_free()


func _ready():
	next_level()
	

func _process(delta):
	if $level and $level.finish:
		next_level()
