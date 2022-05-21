extends Camera

export var distance = 18.0
export var height = 9.0

func _ready():
	set_physics_process(true)
	set_as_toplevel(true)
	set_camera()

func _physics_process(delta):
	
	var target_pos = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	var up = Vector3(0,1,0)
	
	var offset = pos - target_pos
	
	offset = offset.normalized() * distance
	offset.y = height
	
	pos = target_pos + offset
	
	look_at_from_position(pos, target_pos, up)
	 

func set_camera():
	
	var target_pos = get_parent().get_global_transform().origin
	var pos = get_global_transform().origin
	
	var offset = pos - target_pos
	
	offset = offset.normalized() * distance
	offset.y = height
	
	pos = target_pos + offset
	
	#look_at_from_position(pos, target_pos, up)
