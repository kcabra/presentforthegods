extends AnimatedSprite

onready var player = get_parent()

func _ready():
	pass
	
func _process(delta):
	if player.mov_vector.x > 0:
		flip_h = false
	elif player.mov_vector.x < 0:
		flip_h = true
	
	if player.is_on_floor():
		animation = "default"
	else:
		animation = "jump"
