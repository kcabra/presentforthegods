extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_mimir_visble():
	self.modulate.a = 1


func _on_Player_mimir_hidden():
	self.modulate.a = 0
