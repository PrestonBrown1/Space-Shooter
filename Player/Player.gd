extends CharacterBody2D

var speed = 5
var maxSpeed = 3
var rotateSpeed = 5
var barrel = Vector2(60, 0)
var Bullet = load("res://Player/bullet.tscn")

func _physics_process(_delta):
	#Moving
	if (Input.is_action_pressed("Forward")):
		velocity += Vector2(0, -speed).rotated(rotation + deg_to_rad(90))
		get_node("TankBody").play("MoveForward")
		
	if (Input.is_action_pressed("Back")):
		velocity -= Vector2(0, -speed).rotated(rotation + deg_to_rad(90))
		get_node("TankBody").play("MoveBack")
		
	if (Input.is_action_pressed("Left")):
		rotation_degrees -= rotateSpeed
		
	if (Input.is_action_pressed("Right")):
		rotation_degrees += rotateSpeed
		
	if (Input.is_action_just_released("Back") || Input.is_action_just_released("Forward") || Input.is_action_just_released("Left") || Input.is_action_just_released("Right")):
		get_node("TankBody").play("Idle")
		
	if (Input.is_action_just_released("Back") || Input.is_action_just_released("Forward")):
		velocity = Vector2(0, 0)
		
	position.x = wrapf(position.x, 0, 1152)
	position.y = wrapf(position.y, 0, 648)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, maxSpeed)
	
	position = position + velocity
	
	
	#Shooting
	if (Input.is_action_just_pressed("Shoot")):
		var bullet = Bullet.instantiate()
		var Effects = get_node_or_null("/root/Game/Effects")
		
		bullet.position = position + barrel.rotated(rotation)
		bullet.rotation = rotation + deg_to_rad(90)
		
		if (Effects != null):
			Effects.add_child(bullet)
