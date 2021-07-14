extends Node2D


export var current_level = 0
var coins := -1
var lives := -1

func back_to_main():
	var timer := get_tree().create_timer(10)
	yield (timer,"timeout")
	get_tree().change_scene("res://source/Main.tscn")
	
func next_level(increment):
	if $level:
		var player = $level.get_node("player")
		assert (current_level == 0 or player)
		coins=player.coins
		lives=player.lives
	current_level+= increment
	for node in get_children():
		node.queue_free ()
	var interstitial := load ("res://source/Interstitial.tscn")
	var interstitial_scene = interstitial.instance()
	interstitial_scene.set_level (current_level)
	add_child (interstitial_scene)
	if $level and lives < 0 :
		interstitial_scene.game_over()
		back_to_main()
		return
	var level := load ("res://source/level" + str(current_level) + ".tscn")
	if not level:
		interstitial_scene.victory()
		back_to_main()
		return
	var timer := get_tree().create_timer(5)
	yield (timer,"timeout")
	var scene = level.instance()
	add_child(scene)
	interstitial_scene.queue_free()
	var player = $level.get_node("player")
	if coins >= 0:
		player.coins=coins
		player.lives=lives
	else:
		coins=player.coins 
		lives=player.lives
	player.refresh()


func _ready():
	next_level(1)
	

func _process(delta):
	if $level and $level.win:
		next_level(1)
	if $level and $level.loss:
		next_level(0)
