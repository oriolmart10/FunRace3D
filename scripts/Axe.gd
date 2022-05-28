extends Spatial

export(int) var DELAY = 0

func _on_Area_body_entered(body):
	body.death()
