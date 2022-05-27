extends Control

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/LevelCurve.tscn")


func _on_InstrButton_pressed():
	get_tree().change_scene("res://scenes/Instructions.tscn")
