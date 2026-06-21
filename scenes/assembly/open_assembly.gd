extends TextureButton

func _on_button_down():
	SceneLoader.play_sound("res://sound/selection.wav")
	SceneLoader.play_music("res://music/screw_loose.mp3", .5, -3.5)
	SceneLoader.instantiate_file_with_loading_screen_shown("res://scenes/assembly/assembly.tscn")
