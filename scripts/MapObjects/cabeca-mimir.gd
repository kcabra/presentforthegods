extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.name == "Player":
		body.has_mimir = true
		body.modulate = Color(100, 100, 100, 1)
		yield(get_tree().create_timer(0.3), "timeout")
		body.modulate = Color(1, 1, 1, 1)
		self.queue_free()

func _on_body_exited(body):
	if body.name == "Player":
		get_tree().call_group("mimir_object", "hide")
