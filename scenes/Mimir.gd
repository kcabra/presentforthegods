extends Node2D

export (float) var speed
onready var player = $"../../Player"
onready var tween = Tween.new()
var prev = false

func _ready():
	add_child(tween)
	self.modulate = Color (1, 1, 1, 0)

func _process(delta):
	if player.mimir != prev:
		prev = !prev
		match prev:
			true:
				tween.interpolate_property(self, "modulate",
						Color(1, 1, 1, 0), Color(1, 1, 1, 1), speed,
						Tween.TRANS_CUBIC, Tween.EASE_IN)
				tween.start()
				yield(tween, "tween_completed")
			false:
				tween.interpolate_property(self, "modulate",
						Color(1, 1, 1, 1), Color(1, 1, 1, 0), speed,
						Tween.TRANS_CUBIC, Tween.EASE_IN)
				tween.start()
				yield(tween, "tween_completed")

#		self.modulate = Color(1, 1, 1, 1)
#	else:
#		self.modulate = Color(1, 1, 1, 0)