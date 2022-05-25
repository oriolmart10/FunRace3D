extends Spatial

export(int) var DELAY = 0

func _ready():
	var t = Timer.new()
	t.set_wait_time(DELAY)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	print("Play")
	$AnimationPlayer.play("Swing")


func _on_Area_body_entered(body):
	body.death()
