extends Node2D

var tween = Tween.new()
var wiggle_range = 50
var wiggle_time = 2
onready var start_pos = self.position.x
onready var end_pos = start_pos + wiggle_range

func _ready():
	add_child(tween)
	wiggle()
	
func wiggle():
	tween.interpolate_property(self, "position:y",
			start_pos, end_pos, wiggle_time,
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	
	tween.interpolate_property(self, "position:y",
			end_pos, start_pos, wiggle_time,
			Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	wiggle()
