extends Node

onready var player = get_parent()

export (int, -80, 24) var master_fx_volume

var run_fx = AudioStreamPlayer.new()
var jump_fx = AudioStreamPlayer.new()
var land_fx = AudioStreamPlayer.new()
var death_fx = AudioStreamPlayer.new()
var item_fx = AudioStreamPlayer.new()

#airborne check
var airborne = false

func _ready():
	add_child(run_fx)
	add_child(jump_fx)
	add_child(land_fx)
	add_child(death_fx)
	add_child(item_fx)
	run_fx.stream = load("res://assets/sound/fx/run.wav")
	jump_fx.stream = load("res://assets/sound/fx/jump.wav") # play jump fx
	land_fx.stream = load("res://assets/sound/fx/landing.wav")
	death_fx.stream = load("res://assets/sound/fx/death.wav") #play death fx
	item_fx.stream = load("res://assets/sound/fx/item.wav")
	run_fx.volume_db = master_fx_volume
	jump_fx.volume_db = master_fx_volume
	land_fx.volume_db = master_fx_volume
	death_fx.volume_db = master_fx_volume
	item_fx.volume_db = master_fx_volume

func _process(delta):
	#walk fx	
	if (Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left")) and player.is_on_floor():
		run_fx.play()
	if (Input.is_action_just_released("move_right") and !Input.is_action_pressed("move_left")) or (Input.is_action_just_released("move_left") and !Input.is_action_pressed("move_right")) and player.is_on_floor():
		run_fx.stop()
		
	#airborne check
	if !player.is_on_floor():
		airborne = true
		run_fx.stop()
	
	# play land and run fx	
	if player.is_on_floor() and airborne:
		land_fx.play()
		if (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
			run_fx.play()
		airborne = false

func jump():
	jump_fx.play()

func die():
	death_fx.play()

func got_item():
	item_fx.play()

func change_volume(volume):
	master_fx_volume = volume
	run_fx.volume_db = master_fx_volume
	jump_fx.volume_db = master_fx_volume
	land_fx.volume_db = master_fx_volume
	death_fx.volume_db = master_fx_volume
	item_fx.volume_db = master_fx_volume
