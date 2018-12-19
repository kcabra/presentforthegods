extends KinematicBody2D

const death_height = 700

signal player_dead

#item and progression
var has_mimir = false
var has_prometeus = true

#basic movement
var mov_vector : Vector2
export (int) var speed = 300
export (int) var jump_size = -530
export (int) var gravity = 50
export (int) var max_gravity = 600

#camera
onready var camera = $"CameraPivot/CameraOffset/Camera2D"
export (bool) var camera_active = true
var playergaze : Vector2

#movement tolerance
export (float) var tolerance_time = 0.2
var tolerance_jump = 0
var tolerance_ground = 0

#debug
export (Vector2) var save_pos

func _ready():
	self.add_to_group("player")
	save_pos = self.position
	
func _process(delta):
	if camera.current != camera_active:
		camera.current = camera_active
		camera.smoothing_enabled = false
		camera.align()
		camera.smoothing_enabled = true

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
			$AudioControl.jump()
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
		emit_signal("player_dead")
		teleport(save_pos)
		$AudioControl.die()
	
	# reset pos (debug)
	if Input.is_action_just_pressed("ui_page_up"):
		save_pos = self.position
	if Input.is_action_just_pressed("ui_page_down"):
		teleport(save_pos)
	
func teleport(new_position : Vector2):
	camera.smoothing_enabled = false
	self.position = new_position
	camera.smoothing_enabled = true