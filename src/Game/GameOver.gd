extends Control

onready var hs_label = $CenterContainer/VBoxContainer/Hs_label

func setText(aux):
	hs_label.setText(aux)
	
func _ready():
	pass # Replace with function body.

