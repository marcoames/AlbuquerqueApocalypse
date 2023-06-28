extends CanvasLayer

onready var player = get_parent().get_node("Player")

func _ready() -> void:
	pass 

func _on_Atk_speed_button_down() -> void:
	player.setAtk_speed()


func _on_Mov_speed_button_down() -> void:
	player.setMov_speed()
