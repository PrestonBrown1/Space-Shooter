extends CharacterBody2D

var initialSpeed = 100

func _ready():
	velocity = Vector2(0, initialSpeed * randf()).rotated(2 * PI * randf())
	get_node("ZombieBody").play("Walk")
	

func _physics_process(_delta):
	position.x = wrapf(position.x, 0, 1152)
	position.y = wrapf(position.y, 0, 648)
	move_and_slide()
