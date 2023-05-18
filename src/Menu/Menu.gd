extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Start_pressed():
	#pass # Replace with function body.
	get_tree().change_scene("res://src/Game/Game.tscn")

func _on_Quit_pressed():
	#pass # Replace with function body.
	get_tree().quit()
