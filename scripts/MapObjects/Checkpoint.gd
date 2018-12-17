extends Area2D

var saved = false

func _ready():
	connect("body_entered", self, "save")

func save(player):
	if player.name == "Player" and !saved:
		player.save_pos = self.position
		saved = true
