extends Area2D

func _ready():
	pass

func _on_Hitbox_area_entered(area):
	if area.is_in_group("attack"):
		get_parent().setHp(area.getDamage())
		if get_parent().has_method("flash"):
			get_parent().flash()
		if get_parent().has_method("weapon_hit"):
			get_parent().weapon_hit()	
