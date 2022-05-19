extends Area

func _physics_process(delta):
	translate(Vector3(-0.05, 0.0, 0.0))


func _on_VisibilityNotifier_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	body.death()
