extends Node2D

onready var game = get_parent()
onready var player = get_parent().get_node("Player")

func _ready():
	$Boundaries.connect("player_entered", self, "_on_player_entered")

func _on_player_entered():
	
	# location updater
	game.player_location = self.name
	if OS.is_debug_build(): print("changed location: "+game.player_location)
		

func _on_player_exited():
	# release cam
	player.player_camera_active = true