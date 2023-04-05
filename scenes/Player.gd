extends KinematicBody

export var normal_speed = 10.0
export var fast_speed = 20.0
export var low_speed = 5.0
export var gravity = -100.0
export var jump_impulse = 20.0

onready var slowdown_timer = $SlowdownTimer
onready var speed_up_timer = $SpeedUpTimer
onready var lives_count_label = $Control/LivesCountLabel
onready var animation_player = $AnimationPlayer
onready var lady_bug_model = $lady_bug
onready var flickering_timer = $FlickeringTimer

var velocity = Vector3.ZERO
var speed = normal_speed
var got_hurt = false
var flickering_time = 0

var lives = 3

func _ready():
	speed = normal_speed
	update_lives_label(lives)


func _process(delta):
	var move_dir = Vector3.ZERO
	if Input.is_action_pressed("left"):
		move_dir.x -= 1
	if Input.is_action_pressed("right"):
		move_dir.x += 1
	if Input.is_action_pressed("forward"):
		move_dir.z -= 1
	if Input.is_action_pressed("back"):
		move_dir.z += 1
		
#	move_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
#	move_dir.z = Input.get_action_strength("back") - Input.get_action_strength("forward")

	if move_dir != Vector3.ZERO:
		move_dir = move_dir.normalized()
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), speed * delta)
#		look_at(translation + move_dir, Vector3.UP)
#
	velocity.x = move_dir.x * speed
	velocity.z = move_dir.z * speed


	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_impulse
		animation_player.play("jump")
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)
		
	if got_hurt:
		player_flickering(delta)


func update_lives_label(lives):
	lives_count_label.text = "Lives: " + str(lives)
	

func _on_Area_area_entered(area):
	if area.is_in_group("flower"):
		get_tree().change_scene("res://scenes/WinScreen.tscn")
		
	if area.is_in_group("enemy"):
		got_hurt = true
		flickering_timer.start()
		lives -= 1
		if lives <= 0:
			get_tree().change_scene("res://scenes/GameOverScreen.tscn")
		update_lives_label(lives)

	if area.is_in_group("speed_up"):
		area.queue_free()
		speed = fast_speed
		speed_up_timer.start()

	if area.is_in_group("slow_down"):
		area.queue_free()
		speed = low_speed
		slowdown_timer.start()


func player_flickering(delta):
	flickering_time += delta
	if flickering_time > 0.1:
		lady_bug_model.visible = !lady_bug_model.visible
		flickering_time = 0
		


func _on_SpeedUpTimer_timeout():
	speed = normal_speed


func _on_SlowdownTimer_timeout():
	speed = normal_speed


func _on_FlickeringTimer_timeout():
	got_hurt = false
	lady_bug_model.visible = true
	flickering_time = 0
