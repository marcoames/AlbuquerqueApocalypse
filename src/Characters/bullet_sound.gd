extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pitch_scale = rand_range(2,2.2)

func setPitch(x,y):
	pitch_scale = rand_range(x,y)
