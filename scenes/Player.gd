extends KinematicBody

export var normal_speed = 10.0
export var fast_speed = 20.0
export var low_speed = 5.0
export var gravity = -100.0
export var jump_impulse = 20.0

onready var slowdown_timer = $SlowdownTimer
onready var speed_up_timer = $SpeedUpTimer
onready var lives_count_label = $Control/LivesCountLabel


var velocity = Vector3.ZERO
var speed = normal_speed

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
#		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), speed * delta)
		look_at(translation + move_dir, Vector3.UP)
	
	velocity.x = move_dir.x * speed
	velocity.z = move_dir.z * speed
	
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y += jump_impulse
		
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector3.UP)


func update_lives_label(lives):
	lives_count_label.text = "Lives: " + str(lives)
	

func _on_Area_area_entered(area):
	if area.is_in_group("flower"):
		print("Reach the flower")
		
	if area.is_in_group("enemy"):
		lives -= 1
		update_lives_label(lives)

	if area.is_in_group("speed_up"):
		area.queue_free()
		speed = fast_speed
		speed_up_timer.start()

	if area.is_in_group("slow_down"):
		area.queue_free()
		speed = low_speed
		slowdown_timer.start()


func _on_SpeedUpTimer_timeout():
	speed = normal_speed


func _on_SlowdownTimer_timeout():
	speed = normal_speed
