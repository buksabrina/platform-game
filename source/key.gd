extends Area2D


signal transport


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_key_body_entered(body):
	
	if body.name == "player" and not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
		body.collect_key()
		


func _on_AudioStreamPlayer_finished():
	var tree = get_tree()
	var root = tree.get_root()
	var main = root.find_node("game",true,false)
	main.go_to_level(10)
