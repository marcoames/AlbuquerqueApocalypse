extends Label

var time = 0
var timer_on = true

func getTimeString():
	return "%02d" % time
	
func getTime():
	return time	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_process(time)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	if (timer_on):
		time += delta
		
	var secs = fmod(time,60)
	var mins = fmod(time, 60 * 60) / 60
	
	var time_passed = "%02d : %02d" % [mins,secs]
	text = time_passed
