extends KinematicBody2D
class_name Enemy

var speed = 80
var damage = 1
var velocity = Vector2()

var player_position
var target_position

onready var sprite = $AnimatedSprite
onready var player = get_parent().get_node("Player")

onready var hp_bar = get_parent().get_node("HUD").get_child(3)

onready var navigation_path: Navigation2D = get_parent().get_node("pathfinding")
var path : Array = []
var direction = Vector2()


func setHpBar(set_value = 1, set_max_value = 100):
	hp_bar.value += set_value
	hp_bar.max_value = set_max_value


func animation():
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


func _physics_process(delta):
	#if player and navigation_path:
	#	generate_path()
	#	navigate()
		
	
	#move(delta)
	_follow_player(delta)


func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		if global_position == path[0]:
			path.pop_front()
	
	
func generate_path():
	if player != null and navigation_path != null:
		#path = navigation_path.get_simple_path(position, player.position, false)
		var rid = navigation_path.get_rid()
		path = Navigation2DServer.map_get_path(rid, global_position, player.global_position, false, 1)
		



func move(delta):
	target_position = (player.position - position).normalized()
	velocity = global_position.direction_to(player.global_position)
	global_position += velocity * speed * delta
	velocity = move_and_slide(velocity)
	animation()


func _follow_player(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	animation()

	if position.distance_to(player_position) > 5:
		var collision_info = move_and_collide(target_position * speed * delta)

		if collision_info != null and collision_info.collider == player:
			setHpBar(damage,100)
			collision_info.collider.setHp(-damage)
			#print(player.hp)
