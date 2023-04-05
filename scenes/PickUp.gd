extends Area

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("simple_animation")
