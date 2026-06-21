extends BaseButton


func _on_button_down():
	var chasses: Array = SESSIONSTATS.stats.owned_chasses
	
	var equipped_chassis = SESSIONSTATS.stats.equipped_chassis
	
	var loc: int = chasses.find(equipped_chassis)
	
	loc += 1
	loc %= chasses.size()
	
	SESSIONSTATS.stats.equipped_chassis = chasses[loc]
	
	SceneLoader.play_sound("res://sound/weird.wav")
	SceneLoader.play_sound("res://sound/car_unlock.mp3",.6)
	SceneLoader.instantiate_file_with_loading_screen(SceneLoader.scene_path)
	print('done')
