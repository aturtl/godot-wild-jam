class_name ActionJump extends Action


func action_began():
	return action_info


func action_looped():
	action_info.jump_velocity -= Vector2(0,150.0)
	return action_info


func get_debug_name() -> String:
	return "Jump"
