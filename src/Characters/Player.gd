extends KinematicBody2D

var speed = 100
var velocity = Vector2()

onready var killed_boss = false

onready var max_hp = 100
onready var hp = max_hp

onready var level = 1
onready var xp = 0

var atk_speed = 1
var can_fire = true

onready var sprite = $AnimatedSprite
const bulletPath = preload("res://src/Game/Bullet.tscn")
const bulletWidePath = preload("res://src/Game/BulletWide.tscn")

onready var levelPanel = get_parent().get_node("HUD").get_child(4)
onready var upgradeOptions = levelPanel.get_child(1)

func boss_kill():
	killed_boss = true

func level_upgrade():
	$level_up.play()
	levelPanel.visible = true
	get_tree().paused = true
	pass


func setAtk_speed():
	if atk_speed >= 0.25:
			atk_speed -= 0.1
	levelPanel.visible = false
	get_tree().paused = false

func setMov_speed():
	if speed <= 10:
		speed = speed + 1
	levelPanel.visible = false
	get_tree().paused = false
	
	
func setMaxHp(aux):
	max_hp = max_hp + aux

func setHp(aux):
	hp = hp + aux

func getHp():
	return hp
	
func setLvl(aux):
	level += aux
	#$level_up.play()
	xp_level_label.text = str("LVL: ", level)

func getLvl():
	return level

func setXp(aux):
	xp = xp + aux
	if xp >= 100:
		setLvl(1)
		xp = xp -100
		#if level == 10:
			#$I_am_danger.play()
		
		# update window
		level_upgrade()

		#if atk_speed > 0.24:
		#	atk_speed -= 0.1
		#setMaxHp(10)
	setXpBar(xp, 100)	
	xp_level_label.text = str("LVL: ", level)

onready var xp_bar = get_parent().get_node("HUD").get_child(1)
onready var xp_level_label = get_parent().get_node("HUD").get_child(2)

func setXpBar(set_value = 1, set_max_value = 100):
	xp_bar.value = set_value
	xp_bar.max_value = set_max_value

func death():
	$death_sound.play()
	sprite.play("death")

func shoot():
	var bullet = bulletPath.instance()
	
	if level >= 10 and killed_boss:
		bullet = bulletWidePath.instance()
		$bullet_sound.setPitch(0.8,1)
			
	get_parent().add_child(bullet)
	$bullet_sound.play()
	bullet.position = position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	bullet.rotation = bullet.direction.angle()
	can_fire = false
	yield(get_tree().create_timer(atk_speed), "timeout")
	can_fire = true

func _process(_delta):
	if can_fire and hp > 0:
		shoot()

func _physics_process(_delta):
	if hp > 0:
		handle_input()

func handle_input():
	velocity = Vector2()
	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if velocity.y > 0:
		sprite.play("walk_down")
	elif velocity.y < 0:
		sprite.play("walk_up")
	elif velocity.x < 0:
		sprite.play("walk_left")	
	elif velocity.x > 0:
		sprite.play("walk_right")	
	else:
		if hp > 0: 
			sprite.stop()
			sprite.frame = 0
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed)	
