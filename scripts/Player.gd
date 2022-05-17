extends PathFollow

export(float) var velocity = 0.0
var current_state = RUN

onready var animationPlayer = $Player/AnimationPlayer

enum {RUN, IDLE}

func _physics_process(delta):
	if Input.is_action_pressed("ui_walk"):
		current_state = RUN
		offset = offset + velocity
		if current_state == RUN:
			animationPlayer.play("Run")
		if offset >= 20:
			queue_free()
	else:
		current_state = IDLE
		animationPlayer.play("Idle")
