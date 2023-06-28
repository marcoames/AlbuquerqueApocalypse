extends Area2D

var velocity = Vector2(0,0)
var speed = 250
var direction = Vector2.ZERO

var damage = 250

func getDamage():
	return damage

func _ready() -> void:
	pass 

func _process(delta):
	position.x += direction.x * delta * speed
	position.y += direction.y * delta * speed
