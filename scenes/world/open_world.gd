extends Button

func _on_button_down():
	SceneLoader.play_sound("res://sound/selection.wav")
	SceneLoader.instantiate_file_with_loading_screen("res://scenes/world/world.tscn")
