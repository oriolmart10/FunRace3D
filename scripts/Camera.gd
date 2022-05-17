extends Camera

export var distance = 4.0
export var height = 2.0

func _ready():
	set_physics_process(true)
	set_as_toplevel(true)

func _physics_process(delta):
	
	var target_pos = get_parent().get_transform().origin
	var pos = get_transform().origin
	var up = Vector3(0,1,0)
	
	var offset = pos - target_pos
	
	offset = offset.normalized() * distance
	offset.y = height
	
	pos = target_pos + offset
	
	look_at_from_position(pos, target_pos, up)
	 

