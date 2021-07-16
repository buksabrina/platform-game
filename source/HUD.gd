extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_coins(coins):
	$CoinCount.text = str(coins)

func set_lives(lives):
	$lifeCount.text = str(lives)

func set_health(health):
	$healthCount.text = str(health)
