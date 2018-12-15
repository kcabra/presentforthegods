extends Tween

var prometeus_active : bool = true
onready var player = get_parent().get_node("Player")

func _ready():
	randomize()
	
func _process(delta):
	if !player.prometeus:
		self.stop_all()
	else:
		self.resume_all()