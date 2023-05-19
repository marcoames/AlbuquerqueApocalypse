extends KinematicBody2D
class_name Enemy

var speed = 80
var velocity = Vector2()

var player_position
var target_position

onready var sprite = $AnimatedSprite
onready var player = get_parent().get_node("Player")
#onready var player = get_node("res://src/Characters/Player.tscn")


func _physics_process(delta):
	_follow_player(delta)

func _follow_player(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	
	if target_position.x < 0:
		sprite.play("walk_left")	
	elif target_position.x > 0:
		sprite.play("walk_right")
	elif target_position.y > 0:
		sprite.play("walk_down")
	elif target_position.y < 0:
		sprite.play("walk_up")
	else:
		sprite.stop()
		sprite.frame = 0	
	
	if position.distance_to(player_position) > 3:
		#move_and_slide(target_position * speed)
		var collision_info = move_and_collide(target_position * speed * delta)
		if collision_info != null and collision_info.collider == player:
			collision_info.collider.setHp(-2)
