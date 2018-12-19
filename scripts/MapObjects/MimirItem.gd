extends Area2D

export (String) var item

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(player):
	if player.name == "Player":
		match item:
			"mimir":
				player.has_mimir = true
			"prometeus":
				player.has_prometeus = true
		
		$"Sprites".visible = false
		
		player.modulate = Color(100, 100, 100, 1)
		yield(get_tree().create_timer(0.3), "timeout")
		player.modulate = Color(1, 1, 1, 1)
		
		var audio = AudioStreamPlayer.new()
		add_child(audio)
		audio.stream = load("res://assets/sound/GET ITEM.wav")
		audio.play()
		yield(audio, "finished")
		
		player.position = Vector2(505, 238)
		
		self.queue_free()
