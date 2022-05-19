extends KinematicBody

const DeathEffect = preload("res://prefabs/DeathEffect.tscn")

func death():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.scale = Vector3(0.6,0.6,0.6)
	deathEffect.translate(Vector3(0.0, 3.5, 0.0))
	visible = false
	
	$DeathTime.start(1.5)


func _on_DeathTime_timeout():
	print("Entrea")
	get_parent().reset_position_to_spawPoint()
