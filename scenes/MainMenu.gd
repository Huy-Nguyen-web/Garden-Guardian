extends Control


func _on_PlayButton_pressed():
	get_tree().change_scene("res://scenes/World.tscn")


func _on_InstructionButton_pressed():
	get_tree().change_scene("res://scenes/InstructionMenu.tscn")
