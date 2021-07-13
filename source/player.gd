extends KinematicBody2D



var velocity := Vector2.ZERO
export var walk_speed := 100

export var gravity := 2000

func change_animation():
	if velocity.x==0:
		$AnimatedSprite.play("idle")
	else: 
		$AnimatedSprite.play ("walk")
		if velocity.x < 0 :
			$AnimatedSprite.flip_h=true
		elif velocity.x > 0:
			$AnimatedSprite.flip_h=false

func _ready():
	pass

func _physics_process(delta):
	var x = 0
	if Input.is_action_pressed("walk_left"):
		x -= walk_speed
	if Input.is_action_pressed("walk_right"):
		x += walk_speed
	velocity.x=x
	velocity.y+= gravity*delta
	#position+=velocity*delta
	velocity = move_and_slide(velocity,Vector2.UP)

func _process(delta):
	change_animation()
