extends CharacterBody2D

var initialSpeed = 100
var dmg = 10
var health = 50

func _ready():
	velocity = Vector2(0, initialSpeed * randf()).rotated(2 * PI * randf())
	get_node("ZombieBody").play("Walk")
	

func _physics_process(_delta):
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	move_and_slide()

func damage(d):
	health -= d
	
	if (health <= 0):
		Global.updateScore(10)
		queue_free()
