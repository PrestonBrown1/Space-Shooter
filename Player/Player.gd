extends CharacterBody2D

var speed = 5
var maxSpeed = 400
var rotateSpeed = 5

func _physics_process(delta):
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
	
	move_and_slide()
