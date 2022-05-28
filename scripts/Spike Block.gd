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
	if (elapsed >= 1000): 
		curr_state = STATE.WARNING
		ini_time = OS.get_ticks_msec()
		fin_time = ini_time
		var mat = SpatialMaterial.new()
		var tex = preload("res://models/spike_block_release.png")
		mat.albedo_texture = tex
		$MeshInstance.material_override = mat
		
func warn_timer():
	fin_time = OS.get_ticks_msec()
	var elapsed = fin_time - ini_time
	if (elapsed >= 1000): 
		curr_state = STATE.RELEASING
		fin_time = 0
		ini_time = 0
		var mat = SpatialMaterial.new()
		var tex = preload("res://models/spike_block.png")
		mat.albedo_texture = tex
		$MeshInstance.material_override = mat
		var spikes = Spikes.instance()
		child = spikes
		add_child(spikes)
		
func raise_timer():
	child.translate(Vector3(0.0, 0.05, 0.0))
	tot_trans += 0.05
	if (tot_trans >= 1.7):
		curr_state = STATE.RELEASED
		ini_time = OS.get_ticks_msec()
		fin_time = ini_time
		
func released_timer():
	fin_time = OS.get_ticks_msec()
	var elapsed = fin_time - ini_time
	if (elapsed >= 1500): 
		curr_state = STATE.RETRACT
		fin_time = 0
		ini_time = 0
		
func retract_timer():
	child.translate(Vector3(0.0, -0.05, 0.0))
	tot_trans -= 0.05
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
			print("activated")
		STATE.WARNING:
			warn_timer()
			print("warn")
		STATE.RELEASING:
			raise_timer()
			print("reling")
		STATE.RELEASED:
			released_timer()
			print("rel")
		STATE.RETRACT:
			retract_timer()
			print("retr")

func _on_Area_body_entered(body):
	if (not already_active):
		already_active = true
		curr_state = STATE.ACTIVATED
		ini_time = OS.get_ticks_msec()
		fin_time = ini_time
