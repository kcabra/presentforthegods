extends Node

onready var game = get_parent()
var background_loaded = false
var current_background = "PlayerRoom"

var mimir_bg = preload("res://scenes/backgrounds/MimirBackground.tscn")
var prometeus_bg = preload("res://scenes/backgrounds/PrometeusBackground.tscn")

func _process(delta):
	if current_background != game.player_location:
		change_background()

func change_background():
	var previous_background
	# fade_out > update > fade_in
	if current_background != "PlayerRoom":
		previous_background = get_node(current_background + "Background")
		previous_background.queue_free()
	
	current_background = game.player_location # update current_background
	
	if current_background != "PlayerRoom":
		match current_background:
			"Mimir":
				add_child(mimir_bg.instance())
			"Prometeus":
				add_child(prometeus_bg.instance())
