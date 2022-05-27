extends Spatial

enum XURRO_TYPE {CONSTANT,SUDDEN}

enum DIRECTION {CLOCKWISE,ANTICLOCKWISE}

enum STATE {STOPPED,MOVING}

export (XURRO_TYPE) var xurro_type
export (DIRECTION) var direction

var ini_time = 0
var fin_time = 0

var curr_state = STATE.MOVING

var total_degrees = 0

func _physics_process(delta):
	match xurro_type:
		XURRO_TYPE.CONSTANT:
			match direction:
				DIRECTION.CLOCKWISE:
					#rotate 0.5 degrees in y axis for each frame, more or less
					var rotation = 0.167 * PI * delta
					rotate_y(-rotation)
				DIRECTION.ANTICLOCKWISE:
					#rotate -0.5 degrees in y axis for each frame, more or less
					var rotation = 0.167 * PI * delta
					rotate_y(rotation)
		XURRO_TYPE.SUDDEN:
			match curr_state:
				STATE.STOPPED:
					fin_time = OS.get_ticks_msec()
					var elapsed = fin_time - ini_time
					if (elapsed >= 1500): 
						curr_state = STATE.MOVING
						fin_time = 0
						ini_time = 0
				STATE.MOVING:
					match direction:
						DIRECTION.CLOCKWISE:
							#rotate 1 degrees in y axis for each frame, more or less, until 90 are reached
							var rotation = 0.25 * PI * delta
							rotate_y(-rotation)
							total_degrees += rotation
							if (total_degrees >= PI/2):
								curr_state = STATE.STOPPED
								ini_time = OS.get_ticks_msec()
								fin_time = ini_time
								total_degrees = 0
						DIRECTION.ANTICLOCKWISE:
							#rotate 1 degrees in y axis for each frame, more or less, until 90 are reached
							var rotation = 0.25 * PI * delta
							rotate_y(rotation)
							total_degrees += rotation
							if (total_degrees >= PI/2):
								curr_state = STATE.STOPPED
								ini_time = OS.get_ticks_msec()
								fin_time = ini_time
								total_degrees = 0

func _on_Area_body_entered(body):
	body.death()
