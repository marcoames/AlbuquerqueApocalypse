extends KinematicBody2D

var speed = 100
var velocity = Vector2()

onready var hp = 100

onready var sprite = $AnimatedSprite

func collision():
	pass




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
