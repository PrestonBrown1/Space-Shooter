extends Control

var Indicator = load("res://UI/indicator.tscn")
var livesPosition = Vector2(30, 15)
var livesIndex = 30

func _ready():
	updateScore()
	updateTime()
	updateLives()

func updateScore():
	$Score.text = "Score: " + str(Global.score)
	
func updateTime():
	$Time.text = "Time: " + str(Global.time)

func _on_timer_timeout():
	Global.updateTime(-1)
	updateTime()
	
	if Global.time < 0:
		get_tree().change_scene_to_file("res://UI/end_game.tscn")

func updateLives():
	for child in $IndicatorContainer.get_children():
		child.queue_free()
	
	for i in range(Global.lives):
		var indicator = Indicator.instantiate()
		indicator.position = livesPosition + Vector2(livesIndex * i, 0)
		
		$IndicatorContainer.add_child(indicator)
	
