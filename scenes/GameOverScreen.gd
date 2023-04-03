extends Control


func _on_ReplayButton_pressed():
	get_tree().change_scene("res://scenes/World.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
