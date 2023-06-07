extends Enemy

var hp = 500

func setHp(aux):
	hp -= aux
	
func _process(_delta):
	if hp <= 0:
		player.setXp(rand_range(8,10))
		queue_free()
