class_name ActionHeal extends Action


func action_began():
	print("heal")
	action_info.mech.mech_stats.add_modifier("hp",.3)
	var heal = load("res://apple_heal.tscn").instantiate()
	GlobalBattle.battle_holder.add_child(heal)
	heal.global_position = action_info.mech.global_position
	


func action_looped():
	action_info.mech.mech_stats.add_modifier("hp",.03)


func get_debug_name() -> String:
	return "Heal"
