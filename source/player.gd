extends KinematicBody2D



var velocity := Vector2.ZERO
export var walk_speed := 100
export var jump_speed := 500

export var traction := 0.05

export var gravity := 2000

export var coins := 0

export var lives := 3

export var done := false

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
	$Camera2D.smoothing_enabled=true

func _physics_process(delta):
	var x = 0
	if Input.is_action_pressed("walk_left"):
		x -= walk_speed
	if Input.is_action_pressed("walk_right"):
		x += walk_speed
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -=jump_speed
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

func collect_coin():
	coins += 1
	$HUD.set_coins(coins)

func die():
	if not $AudioStreamPlayer.playing and not done:
		$AudioStreamPlayer.play()


func refresh():
	$HUD.set_coins(coins)
	$HUD.set_lives(lives)


func _on_AudioStreamPlayer_finished():
	lives -= 1
	$HUD.set_lives(lives)
	get_parent().loss=true
	done=true
