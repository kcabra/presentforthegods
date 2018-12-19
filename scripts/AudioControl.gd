extends Node

onready var player = get_parent()

export (int, -80, 24) var master_fx_volume

var audioplayerRUN = AudioStreamPlayer.new()
var audioplayerJUMP = AudioStreamPlayer.new()
var audioplayerLAND = AudioStreamPlayer.new()
var audioplayerDEATH = AudioStreamPlayer.new()

#airborne check
var airborne = false

func _ready():
	self.add_child(audioplayerRUN)
	self.add_child(audioplayerJUMP)
	self.add_child(audioplayerLAND)
	self.add_child(audioplayerDEATH)
	audioplayerRUN.volume_db = master_fx_volume
	audioplayerJUMP.volume_db = master_fx_volume
	audioplayerLAND.volume_db = master_fx_volume
	audioplayerDEATH.volume_db = master_fx_volume

func _process(delta):
	#walk fx	
	if (Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left")) and player.is_on_floor():
		audioplayerRUN.stream = load("res://assets/sound/RUN.wav")
		audioplayerRUN.play()
	if (Input.is_action_just_released("move_right") and !Input.is_action_pressed("move_left")) or (Input.is_action_just_released("move_left") and !Input.is_action_pressed("move_right")) and player.is_on_floor():
		audioplayerRUN.stop()
		
	#airborne check
	if !player.is_on_floor():
		airborne = true
		audioplayerRUN.stop()
	
	# play land and run fx	
	if player.is_on_floor() and airborne:
		audioplayerLAND.stream = load("res://assets/sound/LAND_HIGH.wav")
		audioplayerLAND.play()
		if (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
			audioplayerRUN.stream = load("res://assets/sound/RUN.wav")
			audioplayerRUN.play()
		airborne = false

func jump():
	audioplayerJUMP.stream = load("res://assets/sound/JUMP_HIGH.wav") # play jump fx
	audioplayerJUMP.play()

func die():
	audioplayerDEATH.stream = load("res://assets/sound/GAME_OVER.wav") #play death fx
	audioplayerDEATH.play()