extends KinematicBody

export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("ui_walk"):
		direction.x += 1


	velocity.x = direction.x * speed
	#velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
