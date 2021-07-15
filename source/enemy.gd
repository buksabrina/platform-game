extends KinematicBody2D



var velocity := Vector2.ZERO
export var walk_speed := 100
export var jump_speed := 500

export var traction := 0.05

export var gravity := 2000

export var coins := 0

export var lives := 3

export var done := false

var go_left = false

var go_right := false



func change_animation():
	if is_on_floor():
		
		if velocity.x==0:
			$AnimatedSprite.play("idle")
		else: 
			$AnimatedSprite.play ("walk")
			if velocity.x < 0 :
				$AnimatedSprite.flip_h=true
			elif velocity.x > 0:
				$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.play("jump")

func _ready():
	pass

func _physics_process(delta):
	var x = 0
	if go_left:
		x -= walk_speed
	if go_right:
		x += walk_speed
	#velocity.x=x
	velocity.x=lerp(velocity.x,x,traction)
	velocity.x += (x-velocity.x)*traction
	velocity.y+= gravity*delta
	#position+=velocity*delta
	velocity = move_and_slide(velocity,Vector2.UP)
	var level = get_parent()
	if not done and level.event_horizon < position.y:
		die()
	
	

func _process(delta):
	change_animation()


func die():
	if not $AudioStreamPlayer.playing and not done:
		$AudioStreamPlayer.play()





func _on_AudioStreamPlayer_finished():

	done=true
