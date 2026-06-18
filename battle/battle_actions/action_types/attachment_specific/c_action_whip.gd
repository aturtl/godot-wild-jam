class_name ActionWhip extends Action


var dmg = .5
var max_dmg = 11
var current_dmg = 0


func action_began(info: ActionInfo) -> ActionInfo:
	info.move_velocity = Vector2.ZERO
	info.rot_velocity = 90.0
	current_dmg = 0
	return info


func action_looped(info: ActionInfo) -> ActionInfo:
	if info.is_enemy_collision and current_dmg <= max_dmg:
		current_dmg += dmg
		info.enemy_mech.mech_stats.damage(dmg)
	return info


func get_debug_name() -> String:
	return "Chomp"
