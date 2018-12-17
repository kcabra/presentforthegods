extends Node

func _ready():
	for node in get_children():
		node.visible = true
