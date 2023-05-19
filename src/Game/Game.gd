extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

onready var player := $Player

const zombie_path = preload("res://src/Characters/Zombie.tscn")
var can_spawn = true
var spawn_timer = 1

func spawn_zombie():
	if can_spawn:
		var zombie = zombie_path.instance()
		add_child(zombie)
		var pos = player.position
		pos.x += rand_range(-1000,1000)
		pos.y += rand_range(-600,600)		
		zombie.position = pos
		can_spawn = false
		yield(get_tree().create_timer(spawn_timer), "timeout")
		if spawn_timer > 0.2:
			spawn_timer -= 0.0050
		can_spawn = true

func _process(delta):
	if can_spawn:
		spawn_zombie()

func _physics_process(delta):
	if player.hp <= 0:
		player.death()
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().change_scene("res://src/Game/GameOver.tscn")

