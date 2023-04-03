extends Area

export var start_pos = Vector3(0, 0, 0)
export var end_pos = Vector3(0, 0, 0)
export var duration = 3.0

onready var tween = $Tween

func _ready():
	translation = start_pos
	move_to_end()
	
	
func move_to_end():
	tween.interpolate_property(self, "translation", start_pos, end_pos, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()


func move_to_start():
	# Move the enemy back to the start position
	tween.interpolate_property(self, "translation", end_pos, start_pos, duration, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	

func _on_Tween_tween_all_completed():
	if translation == end_pos:
		move_to_start()
	elif translation == start_pos:
		move_to_end()
