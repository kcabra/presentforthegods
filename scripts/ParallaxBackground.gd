extends ParallaxBackground

func _ready():
	var children = self.get_children()
	for node in children:
		node.visible = true
