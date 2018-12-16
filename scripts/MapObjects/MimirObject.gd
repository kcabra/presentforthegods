extends PhysicsBody2D

const fade_duration = 0.3
onready var tween = Tween.new()

func _ready():
	add_to_group("mimir_object")
	collision_layer = 3
	add_child(tween)
	self.modulate.a = 0

func show():
	tween.interpolate_property(self, "modulate",
			Color(1, 1, 1, 0), Color(1, 1, 1, 1), fade_duration,
			Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()

func hide():
	tween.interpolate_property(self, "modulate",
			Color(1, 1, 1, 1), Color(1, 1, 1, 0), fade_duration,
			Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	pass
