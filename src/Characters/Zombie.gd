extends Enemy

var hp = 70

func setHP(aux):
	hp -= aux
		
#func _ready() -> void:
#	pass # Replace with function body.

func _process(delta):
	if hp <= 0:
		player.setXp(10)
		queue_free()
