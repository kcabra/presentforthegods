extends RayCast2D

onready var player = get_parent()

var last_mimir_pos
var mimir_active = false
var on_mimir = false

func _input(event):
	if player.has_mimir:
		# mimir start conditions:
		#  (         button pressed            )     (     on floor     )     (not on mimir platform)
		if event.is_action_pressed("item_mimir") and player.is_on_floor() and !on_mimir:
			mimir_active = true
			get_tree().call_group("mimir_object", "show")
			last_mimir_pos = player.position
	
		# mimir stop conditions:
		# mimir is active   (            player moved         )    (         button released            )
		if mimir_active and ( (last_mimir_pos != player.position) or !Input.is_action_pressed("item_mimir") ):
			mimir_active = false
			get_tree().call_group("mimir_object", "hide")

func _process(delta):
	on_mimir = true if is_colliding() else false