extends Camera2D

const mask_fade_duration = 0.4
onready var tween = Tween.new()

func _ready():
	$Mask.visible = true
	add_child(tween)
	$PlayerDetectorArea.connect("player_entered", self, "_on_player_entered")
	$PlayerDetectorArea.connect("player_exited", self, "_on_player_exited")

func _on_player_entered():
	# fixed cam
	get_tree().set_group("player", "camera_active", false)
	current = true
	align()
	
	# mask
	tween.interpolate_property($Mask, "modulate",
	Color (1,1,1,0), Color(1,1,1,1), mask_fade_duration,
	Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func _on_player_exited():
#	# release cam
	get_tree().set_group("player", "camera_active", true)
	
	# mask
	tween.interpolate_property($Mask, "modulate",
	Color (1,1,1,1), Color(1,1,1,0), mask_fade_duration,
	Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()
