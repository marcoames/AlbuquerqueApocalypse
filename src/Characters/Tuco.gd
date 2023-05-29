extends Enemy

var hp = 2000

func setHP(aux):
	hp -= aux
		

func _process(_delta):
	if hp <= 0:
		player.setLvl(3)
		queue_free()
