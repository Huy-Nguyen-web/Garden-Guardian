extends Camera

onready var player = get_parent()

export var move_speed = 5.0
export var offset = Vector3.ZERO

func _ready():
	set_as_toplevel(true)


func _process(delta):
	global_translation = player.global_translation + offset
#	global_translation = lerp(global_translation, player.global_translation + offset, move_speed * delta)


