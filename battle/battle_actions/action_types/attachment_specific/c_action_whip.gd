class_name ActionWhip extends Action


var dmg = .5
var max_dmg = 11
var current_dmg = 0


func action_began() -> ActionInfo:
	action_info.move_velocity = Vector2.ZERO
	action_info.rot_velocity = 90.0
	current_dmg = 0
	return action_info


func action_looped():
	if action_info.is_enemy_collision and current_dmg <= max_dmg:
		current_dmg += dmg
		action_info.enemy_mech.mech_stats.damage(dmg)
	return action_info


func get_debug_name() -> String:
	return "Chomp"
