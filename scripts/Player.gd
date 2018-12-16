extends KinematicBody2D

#basic movement
var mov_vector : Vector2
export (int) var speed = 300
export (int) var jump_size = -400
export (int) var gravity = 30
export (int) var max_gravity = 300

#player gaze direction
var playergaze : Vector2

#movement tolerance
export (float) var tolerance_time = 0.2
var tolerance_jump = 0
var tolerance_ground = 0
var grounded : bool = false

#items
var has_mimir = true
var has_prometeus = true
var mimir = false
var prometeus = false

func _input(event):
	# mimir action
	if event.is_action_pressed("item_mimir") and mov_vector.x == 0:
		mimir = true
	elif ( mimir and
			(event.is_action_released("item_accept") or mov_vector.x != 0) ):
		mimir = false
	
	# prometeus action
	if event.is_action_pressed("item_prometeus"):
		prometeus = true
	elif prometeus and event.is_action_released("item_prometeus"):
		prometeus = false

func _physics_process(delta):
	# side movement
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
		playergaze.y = -1
	
	# jump
	if is_on_floor():
		tolerance_ground = tolerance_time
	if Input.is_action_just_pressed("move_up"):
		tolerance_jump = tolerance_time
	if tolerance_jump > 0 and tolerance_ground > 0:
		mov_vector.y = jump_size
	
	# time pass
	tolerance_ground -= delta
	tolerance_jump -= delta
	
	# actual move
	mov_vector.x = (mov_vector.x * speed)
	if mov_vector.y < max_gravity:
		mov_vector.y += gravity
	mov_vector = move_and_slide( mov_vector, Vector2(0, -1) )
	
	# reset pos (debug)
	if Input.is_action_just_pressed("ui_cancel"):
		position = Vector2(218, 254)
