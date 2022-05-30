extends Control



func _on_BackButton_pressed():
	$AudioStreamPlayer.play()
	yield($AudioStreamPlayer,"finished")
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_BackButton_mouse_entered():
	$AudioStreamPlayer2.play()
