extends Enemy

var hp = 70

func setHP():
	hp -= 40
		
#func _ready() -> void:
#	pass # Replace with function body.

func _process(delta):
	if hp <= 0:
		queue_free()
