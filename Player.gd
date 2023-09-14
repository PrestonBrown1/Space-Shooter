extends Area2D

var speed = 500
var damage = 10
var velocity = Vector2.ZERO

func _ready():
	velocity = Vector2(0, -speed).rotated(rotation)

func _physics_process(delta):
	position = position + velocity


func _on_body_entered(body):
	queue_free()
