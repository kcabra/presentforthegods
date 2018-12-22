extends Node

var tween = Tween.new()
const fade_duration = 0.2

func _ready():
	add_child(tween)
	for node in get_children():
		if node != tween:
			node.modulate.a = 0.0
			node.visible = true
			fade_in()

func fade_in():
	for node in get_children():
		if node != tween:
			tween.interpolate_property(node, "modulate:a", 0, 1, fade_duration,
					Tween.TRANS_QUAD, Tween.EASE_OUT_IN)
			tween.start()

func fade_out():
	for node in get_children():
		if node != tween:
			if node.name == "Sky":
				tween.interpolate_property(node, "modulate:a", 1, 0, fade_duration*0.5,
						Tween.TRANS_QUAD, Tween.EASE_OUT_IN)
				tween.start()
			else:
				tween.interpolate_property(node, "modulate:a", 1, 0, fade_duration,
						Tween.TRANS_QUAD, Tween.EASE_OUT_IN)
				tween.start()
	yield(tween, "tween_completed")
	self.queue_free()
