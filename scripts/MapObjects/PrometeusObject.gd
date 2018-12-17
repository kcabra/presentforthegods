extends KinematicBody2D

enum Directions {UP_DOWN, LEFT_RIGHT}
export (Directions) var orientation = Directions.UP_DOWN
export (int) var float_amount = 5 # how much it moves to each side (in squares
export (float) var time = 1.0 # how long it takes to go from one edge to the other
export (bool) var invert = false
export (float, 0, 1) var offset = 0 # offset in percentage from 0 to 1
var is_active = false

var init_pos
var up_edge
var bot_edge

var current = true # true is going, false is comming back

onready var tween = Tween.new()

func _ready():
	# tween
	add_child(tween)
	
	# invertion
	if invert: current = !current
	
	# calculate positions
	init_pos = position
	float_amount *= 19
	match orientation:
		Directions.UP_DOWN:
			up_edge = init_pos + Vector2(0, -float_amount)
			bot_edge = init_pos + Vector2(0, float_amount)
		
		Directions.LEFT_RIGHT:
			up_edge = init_pos + Vector2(-float_amount, 0)
			bot_edge = init_pos + Vector2(float_amount, 0)
	
	tween_next()
	stop()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		is_active = true
		move()
	if Input.is_action_just_released("ui_accept"):
		is_active = false
		stop()

func tween_next():
	var initial
	var final
	
	match current:
		true:
			initial = bot_edge
			final = up_edge
		false:
			initial = up_edge
			final = bot_edge
	
	current = !current
	position = initial
	
	tween.interpolate_property(self, "position", initial, final, time,
			Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	tween_next()

func move():
	is_active = true
	tween.resume_all()

func stop():
	is_active = false
	tween.stop_all()
