extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

onready var player := $Player

const zombie_path = preload("res://src/Characters/Zombie.tscn")
const tuco_path = preload("res://src/Characters/Tuco.tscn")
var can_spawn = true
var spawn_timer = 1

onready var timer= $HUD.get_child(0)

func spawn_boss():
	#var x = rand_range(0,100)
	#print(timer.getTime())
	if timer.getTime() > 60 and timer.getTime() < 61:
		var tuco = tuco_path.instance()
		add_child(tuco)
		var pos = player.position
		
		# SPAWN NOS CANTOS DA TELA
		var vpr = get_viewport().size * rand_range(1.1,1.4)
		var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
		var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
		var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
		var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
		var sides = [1,2,3,4]
		var pos_side = sides[randi() % sides.size()]
		var pos1 = Vector2.ZERO
		var pos2 = Vector2.ZERO
		
		match pos_side:
			1:
				pos1 = top_left
				pos2 = top_right
			2:
				pos1 = bottom_left
				pos2 = bottom_right
			3:
				pos1 = top_left
				pos2 = bottom_left
			4:
				pos1 = top_right
				pos2 = bottom_right			
				
		
		pos.x = rand_range(pos1.x,pos2.x)
		pos.y = rand_range(pos1.y,pos2.y)
		
		tuco.position = pos

func spawn_zombie():
	
	if can_spawn:
		var zombie = zombie_path.instance()
		add_child(zombie)
		var pos = player.position
		
		# SPAWN NOS CANTOS DA TELA
		var vpr = get_viewport().size * rand_range(1.1,1.4)
		var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
		var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
		var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
		var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
		var sides = [1,2,3,4]
		var pos_side = sides[randi() % sides.size()]
		var pos1 = Vector2.ZERO
		var pos2 = Vector2.ZERO
		
		match pos_side:
			1:
				pos1 = top_left
				pos2 = top_right
			2:
				pos1 = bottom_left
				pos2 = bottom_right
			3:
				pos1 = top_left
				pos2 = bottom_left
			4:
				pos1 = top_right
				pos2 = bottom_right			
				
		
		pos.x = rand_range(pos1.x,pos2.x)
		pos.y = rand_range(pos1.y,pos2.y)
		
		zombie.position = pos
		can_spawn = false
		yield(get_tree().create_timer(spawn_timer), "timeout")
		if spawn_timer > 0.2:
			spawn_timer -= 0.0050
		can_spawn = true

func _process(_delta):
	if can_spawn:
		spawn_zombie()
		spawn_boss()

func _physics_process(_delta):
	if player.hp <= 0:
		player.death()
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().change_scene("res://src/Game/GameOver.tscn")

