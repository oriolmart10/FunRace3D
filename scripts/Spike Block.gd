extends Spatial

enum STATE {INACTIVE,ACTIVATED,WARNING,RELEASING,RELEASED,RETRACT}

var curr_state = STATE.INACTIVE

var ini_time = 0
var fin_time = 0

var already_active = false

var tot_trans = 0

const dist = 0.5

var child

var velocity = 0.5

var Spikes = preload("res://prefabs/Spikes.tscn")

func activ_timer():
	fin_time = OS.get_ticks_msec()
	var elapsed = fin_time - ini_time
	if (elapsed >= 1500): 
		curr_state = STATE.WARNING
		fin_time = 0
		ini_time = 0
		var mat = ResourceLoader.load("res://models/spike_block_release.png")
		$MeshInstance.set_surface_material(0,mat)
		
func warn_timer():
	fin_time = OS.get_ticks_msec()
	var elapsed = fin_time - ini_time
	if (elapsed >= 1000): 
		curr_state = STATE.RELEASING
		fin_time = 0
		ini_time = 0
		var mat = ResourceLoader.load("res://models/spike_block.png")
		$MeshInstance.set_surface_material(0,mat)
		var spikes = Spikes.instance()
		child = spikes
		add_child(spikes)
		
func raise_timer():
	child.translate(Vector3(0.0, 0.5, 0.0))
	tot_trans += 0.5
	if (tot_trans >= 3):
		curr_state = STATE.RELEASED
		
func released_timer():
	fin_time = OS.get_ticks_msec()
	var elapsed = fin_time - ini_time
	if (elapsed >= 1500): 
		curr_state = STATE.RETRACT
		fin_time = 0
		ini_time = 0
		
func retract_timer():
	child.translate(Vector3(0.0, -0.5, 0.0))
	tot_trans -= 0.5
	if (tot_trans <= 0):
		curr_state = STATE.INACTIVE
		already_active = false
		child.disappear()


func _physics_process(delta):
	match curr_state:
		STATE.INACTIVE:
			pass
		STATE.ACTIVATED:
			activ_timer()
		STATE.WARNING:
			warn_timer()
		STATE.RELEASING:
			raise_timer()
		STATE.RELEASED:
			released_timer()
		STATE.RETRACT:
			retract_timer()

func _on_Area_body_entered(body):
	if (not already_active):
		already_active = true
		curr_state = STATE.ACTIVATED
		ini_time = OS.get_ticks_msec()
		fin_time = ini_time
