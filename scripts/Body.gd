extends KinematicBody

const DeathEffect = preload("res://prefabs/DeathEffect.tscn")

func death():
	get_parent().set_death_state()
	make_death_effect()
	$DeathTime.start(1.5)

func set_respawn_point():
	get_parent().set_respawn_point()

func _on_DeathTime_timeout():
	get_parent().reset_position_to_spawPoint()

func make_death_effect():
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.scale = Vector3(0.6,0.6,0.6)
	deathEffect.translate(Vector3(0.0, 4.0, 0.0))
	visible = false
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)

func crawlTrigger():
	get_parent().crawl()

func victory():
	pass
