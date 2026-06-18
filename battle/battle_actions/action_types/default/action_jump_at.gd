class_name ActionJumpAt extends Action

var dmg = 2.0

func action_began(info: ActionInfo) -> ActionInfo:
	info.g_velocity = Vector2(0,0)
	info.jump_velocity = Vector2(0,1200.0)
	info.move_velocity = info.direction_to_enemy*64.0
	return info

func action_looped(info: ActionInfo) -> ActionInfo:
	if info.is_enemy_collision:
		pass
	return info


func get_debug_name() -> String:
	return "Jump At"
