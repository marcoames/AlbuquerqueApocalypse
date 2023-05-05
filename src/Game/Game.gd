extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

onready var player := $Player


func _physics_process(delta: float) -> void:
	if player.hp < 0:
		get_tree().change_scene("res://src/Menu/GameOver.tscn")
