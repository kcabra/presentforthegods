extends Node2D

var player_location = "PlayerRoom"

func _ready():
	self.modulate.a = 0
	var original_volume = $Player/AudioControl.master_fx_volume
	$Player/AudioControl.master_fx_volume = -80
	var tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(self, "modulate:a",
			0, 1, 5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	tween.interpolate_method($Player/AudioControl, "change_volume",
			-30, original_volume, 5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	yield(tween, "tween_completed")
	