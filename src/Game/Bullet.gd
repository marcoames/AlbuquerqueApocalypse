extends KinematicBody2D

var velocity = Vector2(0,0)
var speed = 250
var direction = Vector2.ZERO

var damage = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(direction * delta * speed)
	if collision_info != null:
		#print(collision_info.collider.name)
		if collision_info.collider.has_method("setHP"):
			collision_info.collider.setHP(damage)
			queue_free()
	pass
