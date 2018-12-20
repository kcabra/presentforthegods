extends Node2D

func _ready():
	$"Mimir Map (Ida)".queue_free()
	var scene = load("res://scenes/levels/mimirlevel/MimirLevelIda.tscn")
	yield(get_tree().create_timer(3), "timeout")
	add_child(scene.instance())
