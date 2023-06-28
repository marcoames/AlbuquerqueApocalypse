extends Label

func setText(aux):
	var secs = fmod(aux,60)
	var mins = fmod(aux, 60 * 60) / 60
	
	var time_passed = "%02d : %02d" % [mins,secs]
	text = time_passed
