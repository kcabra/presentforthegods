extends Node2D

enum MovementPhases {FIRST_UP, DOWN, SECOND_UP}
var move_phase = MovementPhases.FIRST_UP

export (int, -500, 500) var move_first = 100 # how much it moves (- up, + down)
export (int, -500, 500) var move_second = -100 # how much it moves (- up, + down)
export (float, 0, 5, 0.2) var time = 2.0 # how long tween takes in seconds to go from highest to lowest

onready var tweener : Tween = get_parent()
var init_pos = self.position
var first_end_pos = init_pos + Vector2(0, move_first)
var second_end_pos = init_pos + Vector2(0, move_second)
var pillar_active : bool = false


func _ready():
	get_parent().connect("tween_completed", self, "_on_tween_completed")
	
	yield(get_tree().create_timer(randf()*3), "timeout") # wait a random amount of time
	pillar_active = true

func _process(delta):

	if pillar_active:
		match move_phase:
			MovementPhases.FIRST_UP:
				tweener.interpolate_property(self, "position", init_pos, first_end_pos, (time/2), Tween.TRANS_SINE, Tween.EASE_OUT)
			MovementPhases.DOWN:
				tweener.interpolate_property(self, "position", first_end_pos, second_end_pos, time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
			MovementPhases.SECOND_UP:
				tweener.interpolate_property(self, "position", second_end_pos, init_pos, (time/2), Tween.TRANS_SINE, Tween.EASE_IN)
		tweener.start()
		pillar_active = false

func _on_tween_completed(object, key):
	if object == self:
		if move_phase < 2:
			move_phase += 1
		else:
			move_phase = 0
		pillar_active = true