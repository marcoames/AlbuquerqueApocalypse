extends KinematicBody2D

var speed = 100
var velocity = Vector2()

onready var max_hp = 100
onready var hp = max_hp

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

func collision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("I collided with ", collision.collider.name)
		setHp(-5)

func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.position = get_global_position()
	bullet.apply_impulse(Vector2(), Vector2(bullet.speed,0))
	can_fire = false
	yield(get_tree().create_timer(atk_speed), "timeout")
	can_fire = true

func _process(delta):
	collision()
	if Input.is_action_just_pressed("fire") and can_fire:
		shoot()

func _physics_process(delta):
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
		sprite.stop()
		sprite.frame = 0
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed)	

