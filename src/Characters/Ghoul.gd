extends Enemy

var hp = 750

func setHp(aux):
	hp -= aux
	
func flash():
	$AnimatedSprite/AnimationPlayer.play("Hit")
		
func _process(_delta):
	if hp <= 0:
		player.setXp(rand_range(3,5))
		queue_free()
