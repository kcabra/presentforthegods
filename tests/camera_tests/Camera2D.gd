extends Camera2D

func _ready():
	get_root(self)
	pass

func get_root(node):
	if node.get_parent() == get_tree().root:
		print("got it! it's "+node.name)
		return node
	else:
		get_root(node.get_parent())