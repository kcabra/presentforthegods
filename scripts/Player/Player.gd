extends KinematicBody2D

const death_height = 700

#item and progression
var has_mimir = false
var has_prometeus = true

#soundfx
var audioplayerRUN = AudioStreamPlayer.new()
var audioplayerJUMP = AudioStreamPlayer.new()
var audioplayerLAND = AudioStreamPlayer.new()
var audioplayerDEATH = AudioStreamPlayer.new()

#airborne check
var airborne = false

#basic movement
var mov_vector : Vector2
export (int) var speed = 300
export (int) var jump_size = -530
export (int) var gravity = 50
export (int) var max_gravity = 600

#camera
onready var camera = $"Pivot/CameraOffset/Camera2D"
export (bool) var player_camera_active = true
var playergaze : Vector2

#movement tolerance
export (float) var tolerance_time = 0.2
var tolerance_jump = 0
var tolerance_ground = 0

#debug
var save_pos

func _ready():
	save_pos = self.position
	self.add_child(audioplayerJUMP)
	self.add_child(audioplayerRUN)
	self.add_child(audioplayerLAND)
	self.add_child(audioplayerDEATH)
	
func _process(delta):
	if camera.current != player_camera_active:
		camera.current = player_camera_active
		camera.align()

func _physics_process(delta):
	# side movement and player gaze
	if Input.is_action_pressed("move_right"):
		mov_vector.x = 1
		playergaze.x = 1
	elif Input.is_action_pressed("move_left"):
		mov_vector.x = -1
		playergaze.x = -1
	else:
		mov_vector.x = 0
		
	#walk fx	
	if (Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left")) and is_on_floor():
		audioplayerRUN.stream = load("res://assets/sound/RUN.wav")
		audioplayerRUN.play()
	if (Input.is_action_just_released("move_right") and !Input.is_action_pressed("move_left")) or (Input.is_action_just_released("move_left") and !Input.is_action_pressed("move_right")) and is_on_floor():
		audioplayerRUN.stop()
	
	#airborne check
	if !is_on_floor():
		airborne = true
		audioplayerRUN.stop()
	
	# play land and run fx	
	if is_on_floor() and airborne == true:
		audioplayerLAND.stream = load("res://assets/sound/LAND_HIGH.wav")
		audioplayerLAND.play()
		if (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")):
			audioplayerRUN.stream = load("res://assets/sound/RUN.wav")
			audioplayerRUN.play()
		airborne = false	
		
	# player looking down
	if Input.is_action_pressed("ui_down"):
		playergaze.y = 1
	else:
		playergaze.y = 0
	
	# jump
	if is_on_floor():
		tolerance_ground = tolerance_time
	if Input.is_action_just_pressed("move_up"):
		tolerance_jump = tolerance_time
		if tolerance_jump > 0 and tolerance_ground > 0:
			audioplayerJUMP.stream = load("res://assets/sound/JUMP_HIGH.wav") # play jump fx
			audioplayerJUMP.play()
	if tolerance_jump > 0 and tolerance_ground > 0:
		mov_vector.y = jump_size

	#dynamic jump
	if !Input.is_action_pressed("move_up"):
		if mov_vector.y < 0:
			mov_vector.y = mov_vector.y*0.5 #pra deixar mais smooth eh so mudar esse numero
	
	# time pass
	tolerance_ground -= delta
	tolerance_jump -= delta
	
	# actual move
	mov_vector.x = (mov_vector.x * speed)
	if mov_vector.y < max_gravity:
		mov_vector.y += gravity
	mov_vector = move_and_slide( mov_vector, Vector2(0, -1) )
	
	#death
	if position.y >= death_height:
		position = save_pos
		audioplayerDEATH.stream = load("res://assets/sound/GAME_OVER.wav") #play death fx
		audioplayerDEATH.play()
	
	# reset pos (debug)
	if Input.is_action_just_pressed("ui_page_up"):
		save_pos = self.position
	if Input.is_action_just_pressed("ui_page_down"):
		position = save_pos