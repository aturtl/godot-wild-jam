extends Button

func _on_button_down():
	SceneLoader.instantiate_file_with_loading_screen("res://scenes/battle/battle.tscn")
