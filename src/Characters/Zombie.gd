extends Enemy

var hp = 100

func setHP(aux):
	hp -= aux
		
#func _ready() -> void:
#	pass # Replace with function body.

func _process(_delta):
	if hp <= 0:
		$AudioStreamPlayer2D.play()
		player.setXp(rand_range(5,10))
		#player.setXp(101)
		queue_free()
