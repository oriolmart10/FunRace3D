extends Spatial

var Bullet = preload("res://prefabs/Bullet.tscn")

func _on_Timer_timeout():
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.translate(Vector3(0.0, 3.4, 0.0))

