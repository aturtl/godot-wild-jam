extends Button



func _on_button_down():
	var chasses: Array = SESSIONSTATS.stats.owned_chasses
	
	var equipped_chassis = SESSIONSTATS.stats.equipped_chassis
	
	var loc: int = chasses.find(equipped_chassis)
	
	loc += 1
	loc %= chasses.size()
	
	SESSIONSTATS.stats.equipped_chassis = chasses[loc]
	
	get_tree().reload_current_scene()
