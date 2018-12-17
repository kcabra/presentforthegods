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
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			animation = "walk"
		else:
			animation = "idle"
	else:
		animation = "jump"
	
