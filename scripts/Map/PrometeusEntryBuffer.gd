extends Node2D

onready var game = get_parent()

func _ready():
	$Area2D.connect("player_entered", self, "load_level")

func load_level():
	game.prometeus_loaded = true
	game.load_scene("levels/prometeuslevel/PrometeusLevelIda", $Mountpoint)
