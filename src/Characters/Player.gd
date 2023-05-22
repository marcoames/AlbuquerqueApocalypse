extends KinematicBody2D

var speed = 100
var velocity = Vector2()

onready var max_hp = 100
onready var hp = max_hp

onready var level = 1
onready var xp = 0

var atk_speed = 1
var can_fire = true

onready var sprite = $AnimatedSprite
const bulletPath = preload("res://src/Game/Bullet.tscn")

func setSpeed(aux):
	speed = speed + aux
	
func setMaxHp(aux):
	max_hp = max_hp + aux

func setHp(aux):
	hp = hp + aux

func getHp():
	return hp

func setXp(aux):
	xp = xp + aux
	xp_level_label.text = str("LVL: ", level)
	setXpBar(xp, 100)
	if xp >= 100:
		level += 1
		xp = 0
		if atk_speed > 0.21:
			atk_speed -= 0.05
		#setSpeed(1)
		#setMaxHp(10)

onready var xp_bar = get_parent().get_node("HUD").get_child(1)
onready var xp_level_label = get_parent().get_node("HUD").get_child(2)



func setXpBar(set_value = 1, set_max_value = 100):
	xp_bar.value = set_value
	xp_bar.max_value = set_max_value


func death():
	sprite.play("death")

#func collision():
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		#print(collision.collider.name)	
#		setHp(-1)

func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	$bullet.play()
	bullet.position = position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	bullet.rotation = bullet.direction.angle()
	can_fire = false
	yield(get_tree().create_timer(atk_speed), "timeout")
	can_fire = true

func _process(_delta):
	#collision()
	if can_fire and hp > 0:
		shoot()

func _physics_process(_delta):
	if hp > 0:
		handle_input()

func handle_input():
	velocity = Vector2()
	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if velocity.y > 0:
		sprite.play("walk_down")
	elif velocity.y < 0:
		sprite.play("walk_up")
	elif velocity.x < 0:
		sprite.play("walk_left")	
	elif velocity.x > 0:
		sprite.play("walk_right")	
	else:
		if hp > 0: 
			sprite.stop()
			sprite.frame = 0
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed)	
	#collision()
