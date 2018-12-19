extends Position2D

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		position.x = 300
	else:
		position.x = 250