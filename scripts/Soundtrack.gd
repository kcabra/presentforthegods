extends AudioStreamPlayer

export (bool) var mute = false

onready var game = get_parent()
var tween = Tween.new()
var currentTrack

func _ready():
	$"../Player".connect("has_died", self, "change_track")
	add_child(tween)
	if mute:
		self.queue_free()
	

func _process(delta):
	if currentTrack != game.player_location:
		change_track()
	
func change_track():
	currentTrack = game.player_location
	stream = load("res://assets/sound/" + currentTrack + ".wav")
	play()