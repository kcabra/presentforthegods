extends Node2D

var tween = Tween.new()

func _input(event):
	add_child(tween)
	var game = preload("res://scenes/Game.tscn")
	tween.interpolate_property(self, "modulate:a",
			1, 0, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	get_tree().change_scene_to(game)