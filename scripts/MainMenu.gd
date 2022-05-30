extends Control

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/Level01.tscn")

func _on_InstrButton_pressed():
	get_tree().change_scene("res://scenes/Instructions.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()
