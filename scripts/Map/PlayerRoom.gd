extends Node2D

onready var game = get_parent()
onready var player = get_parent().get_node("Player")

func _ready():
	$"Area2D".connect("player_entered", self, "enter_room")
	$"Area2D".connect("player_exited", self, "exit_room")

func enter_room():
	# cam
	player.player_camera_active = false
	$RoomView.current = true
	$RoomView.align()
	
	# level unloading
	if game.mimir_loaded:
		game.mimir_loaded = false
		for level in $"../MimirLevel/Mountpoint".get_children():
			level.queue_free()
	if game.prometeus_loaded:
		game.prometeus_loaded = false
		for level in $"../PrometeusLevel/Mountpoint".get_children():
			level.queue_free()

func exit_room():
	# cam
	player.player_camera_active = true