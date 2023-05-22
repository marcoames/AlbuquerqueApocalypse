extends Enemy

var hp = 2000

func setHP(aux):
	hp -= aux
		
#func _ready() -> void:
#	pass # Replace with function body.

func _process(_delta):
	if hp <= 0:
		player.setXp(100)
		queue_free()
