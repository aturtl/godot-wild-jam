class_name ActionChomp extends Action


var dmg = 5.0

var can_dmg = false

func action_began():
	can_dmg = true
	action_info.rot_velocity = 90.0
	return action_info


func action_looped():
	if action_info.is_enemy_collision and can_dmg:
		can_dmg = false
		action_info.enemy_mech.mech_stats.damage(dmg)
	return action_info


func get_debug_name() -> String:
	return "Chomp"
