extends PathFollow

onready var animationPlayer = $Player/AnimationPlayer

export(float) var velocity = 0.0

var current_state = IDLE
var respawn_point = 0

enum {RUN, IDLE, DEATH}

func _physics_process(delta):
	if current_state != DEATH:
		if Input.is_action_pressed("ui_walk"):
			current_state = RUN
			offset = offset + velocity
			if current_state == RUN:
				animationPlayer.play("Run")
		else:
			current_state = IDLE
			animationPlayer.play("Idle")


func reset_position_to_spawPoint():
	offset = respawn_point
	$Player.visible = true
	current_state = IDLE
	
func set_respawn_point():
	respawn_point = offset
	print("Respawn point set at: " + String(offset))

func set_death_state():
	current_state = DEATH
