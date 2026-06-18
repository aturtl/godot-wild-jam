class_name ActionChomp extends Action


var dmg = 5.0

var can_dmg = false

func action_began(info: ActionInfo) -> ActionInfo:
	can_dmg = true
	info.move_velocity = Vector2.ZERO
	info.rot_velocity = 90.0
	return info


func action_looped(info: ActionInfo) -> ActionInfo:
	if info.is_enemy_collision and can_dmg:
		can_dmg = false
		info.enemy_mech.mech_stats.damage(dmg)
	return info


func get_debug_name() -> String:
	return "Chomp"
