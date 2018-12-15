extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0
	pass # Replace with function body.

func _process(delta):
	if get_parent().get_node("Player").mimir:
		self.modulate.a = 1
	else:
		self.modulate.a = 0
