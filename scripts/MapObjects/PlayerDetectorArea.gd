extends Area2D

signal player_entered
signal player_exited

func _ready():
	connect("body_entered", self, "is_player_enter")

func is_player_enter(body):
	if body.is_in_group("player"):
		emit_signal("player_entered")

func is_player_exit(body):
	if body.is_in_group("player"):
		emit_signal("player_exited")
