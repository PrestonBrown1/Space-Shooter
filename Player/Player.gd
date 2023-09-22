extends CharacterBody2D

var speed = 5
var dmg = 0
var maxSpeed = 3
var rotateSpeed = 3.5
var health = 100
var barrel = Vector2(60, 0)
var Bullet = load("res://Player/bullet.tscn")
var Effects = null
var Explosion = load("res://explosion.tscn")

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
		
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, maxSpeed)
	
	position = position + velocity
	
	
	#Shooting
	if (Input.is_action_just_pressed("Shoot")):
		var bullet = Bullet.instantiate()
		Effects = get_node_or_null("/root/Game/Effects")
		
		bullet.position = position + barrel.rotated(rotation)
		bullet.rotation = rotation + deg_to_rad(90)
		
		if (Effects != null):
			Effects.add_child(bullet)
			
func damage(dmg):
	health -= dmg
	
	if (health <= 0):
		Effects = get_node_or_null("/root/Game/Effects")
		if (Effects != null):
			var explosion = Explosion.instantiate()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			explosion.scale = Vector2(.6, .6)
			hide()
			await explosion._on_animation_finished
			
		Global.updateLives(-1)
		queue_free()


func _on_area_2d_body_entered(body):
	if (body.name != "Player"):
		damage(body.dmg)
		print("Damage")
		print(body.damage)
		print("Health")
		print(health)
