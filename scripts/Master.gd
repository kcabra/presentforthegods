extends Node2D

var prometeus_loaded = false
var mimir_loaded = false

func _ready():
	pass

func load_scene(ScenePath, mountpoint):
	var scene = load("res://scenes/" + ScenePath + ".tscn")
	var node = scene.instance()
	mountpoint.add_child(node)
