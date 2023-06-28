extends Enemy

var hp = 2000

onready var player1 = get_parent().get_node("Player")

func _ready():
	pass

func setHp(aux):
	hp -= aux
	
func flash():
	$AnimatedSprite/AnimationPlayer.play("Hit")
	
func weapon_hit():
	#play weapon_hit
	pass	
	
func _process(_delta):
	if hp <= 0:
		player.boss_kill()
		player.setLvl(3)
		queue_free()
		player1.get_child(7).play()
