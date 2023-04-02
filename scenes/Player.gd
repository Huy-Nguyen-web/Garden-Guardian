extends KinematicBody

export var speed = 10.0
export var fast_speed = 20.0
export var low_speed = 5.0
export var gravity = -10.0

var velocity = Vector3.ZERO


func _ready():
	pass # Replace with function body.


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
	
	velocity = move_and_slide(velocity, Vector3.UP)


func _on_Area_area_entered(area):
	if area.is_in_group("flower"):
		print("Reach the flower")


