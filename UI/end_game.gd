extends Control

func _ready():
	$Label.text = "We wanted your brains! Score: " + str(Global.score)

func _on_play_pressed():
	Global.reset()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_pressed():
	get_tree().quit()
