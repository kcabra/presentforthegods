extends Node2D

var player_location = "PlayerRoom"

func _ready():
	var original_volume = $Player/AudioControl.master_fx_volume
	$Player/AudioControl.master_fx_volume = -80
	var tween = Tween.new()
	add_child(tween)
	$start_fade_in.modulate.a = 1
	tween.interpolate_property($start_fade_in, "modulate:a",
			1, 0, 2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	tween.interpolate_method($Player/AudioControl, "change_volume",
			-30, original_volume, 5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	yield(tween, "tween_completed")
	