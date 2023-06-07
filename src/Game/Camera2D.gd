extends Camera2D

var shake_ammount = 0
var default_offset = offset
onready var tween = $Tween
onready var timer = $Timer

func _ready():
	set_process(false)
	randomize()
	
func _process(_delta):
	offset = Vector2(rand_range(-1,1) * shake_ammount, rand_range(-1,1) * shake_ammount)	

func shake(time, ammount):
	timer.wait_time = time
	shake_ammount = ammount
	set_process(true)
	timer.start()
	
func _on_Timer_timeout():
	set_process(false)
	tween.interpolate_property(self, "offset", default_offset, 1, 6, 2)	
	tween.start()
