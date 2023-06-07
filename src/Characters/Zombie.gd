extends Enemy

var hp = 100
onready var sound = get_parent().get_node("enemy_death")

func setHp(aux):
	hp -= aux
	
func _process(_delta):
	if hp <= 0:
		player.setXp(rand_range(8,10))
		sound.setPitch(0.7,1)
		sound.play()
		queue_free()
