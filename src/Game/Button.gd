extends Button

func _ready() -> void:
	pass

func _on_Button_pressed() -> void:
		get_tree().change_scene("res://src/Menu/Menu.tscn")
