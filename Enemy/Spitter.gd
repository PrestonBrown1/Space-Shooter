extends CharacterBody2D

var health = 10
var dmg = 10
var yPositions = [100, 150, 200, 250, 500, 600]
var initialPosition = Vector2.ZERO
var direction = Vector2(1.5, 0)
var wobble = 30

var Spit = load("res://Enemy/spitter_spit.tscn")

func _ready():
	get_node("SpitterBody").play("Walk")
	initialPosition.x = -100
	initialPosition.y = yPositions[randi() % yPositions.size()]
	position = initialPosition
	
func _physics_process(_delta):
	position += direction
	position.y = initialPosition.y + sin(position.x / 20) * wobble 
	
	if (position.x > Global.VP.x + 100):
		queue_free()

func _on_timer_timeout():
	var Player = get_node_or_null("/root/Game/PlayerContainer/Player")
	var Effects = get_node_or_null("/root/Game/Effects")
	
	if (Player != null and Effects != null):
		var spit = Spit.instantiate()
		var direction = global_position.angle_to_point(Player.global_position) + PI / 2
		spit.rotation = direction
		spit.position = position
		position += Vector2(0, -40)
		Effects.add_child(spit)
		
func damage(dmg):
	health -= dmg
	
	if (health <= 0):
		Global.updateScore(20)
		queue_free()


func _on_area_2d_body_entered(body):
	if (body.name != "Spitter"):
		damage(body.dmg)
