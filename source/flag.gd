extends Area2D


signal win 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_flag_body_entered(body):
	if body.name == "player" and not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
		body.done=true
		


func _on_AudioStreamPlayer2D_finished():
	emit_signal("win")
		
