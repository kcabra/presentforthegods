extends Node

var has_mimir = true
var has_prometeus = true
var mimir = false
var prometeus = true
onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# mimir action
	if event.is_action_pressed("item_mimir"):
		player.mimir = true
	elif player.mimir and event.is_action_released("item_mimir"):
		player.mimir = false
	
	# prometeus action
	if event.is_action_pressed("item_prometeus"):
		player.prometeus = true
	elif player.prometeus and event.is_action_released("item_prometeus"):
		player.prometeus = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
