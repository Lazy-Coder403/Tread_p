extends Node3D
func _process(delta):
	rotation.y += 1.0*delta


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Main/Scenes/game.tscn")


func _on_quit_pressed():
	get_tree().quit()
