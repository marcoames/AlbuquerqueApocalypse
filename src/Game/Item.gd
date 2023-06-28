extends Area2D

onready var hp_bar = get_parent().get_node("HUD").get_child(3)
func setHpBar(set_value = 1, set_max_value = 100):
	hp_bar.value += set_value
	hp_bar.max_value = set_max_value


func _on_Item_body_entered(body: Node) -> void:
	$pick_up_sound.play()
	$Sprite.visible = false
	#print("set hp")
	body.setHp(25)
	setHpBar(-25,100)
	#queue_free()
	yield($pick_up_sound, "finished") 
	queue_free()
