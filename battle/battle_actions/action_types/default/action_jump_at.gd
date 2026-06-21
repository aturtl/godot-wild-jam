class_name ActionJumpAt extends Action

var dmg = 2.0

func action_began():
	action_info.g_velocity = Vector2(0,0)
	action_info.jump_velocity = Vector2(0,1200.0)
	action_info.move_velocity = action_info.direction_to_enemy*64.0
	return action_info

func action_looped():
	if action_info.is_enemy_collision:
		action_info.enemy_mech.mech_stats.damage(dmg)
	return action_info


func get_debug_name() -> String:
	return "Jump At"
