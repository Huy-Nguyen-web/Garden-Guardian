extends Control


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/World.tscn")
	

func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
