extends PathFollow2D

export (int) var speed = 50

func _process(delta):
	self.offset += delta * speed
