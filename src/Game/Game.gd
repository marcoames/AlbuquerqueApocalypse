extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

onready var player := $Player

const zombie_path = preload("res://src/Characters/Zombie.tscn")
var can_spawn = true

func spawn_zombie():
	if can_spawn:
		var zombie = zombie_path.instance()
		add_child(zombie)
		zombie.position = Vector2(randi()%100,randi()%100)
		can_spawn = false
		yield(get_tree().create_timer(2), "timeout")
		can_spawn = true

func _process(delta):
	spawn_zombie()
	pass

func _physics_process(delta: float) -> void:
	if player.hp < 0:
		get_tree().change_scene("res://src/Game/GameOver.tscn")

