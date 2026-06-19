class_name ActionBackup extends Action


func action_began():
	initial_direction = -action_info.direction_to_enemy
	return action_info


func action_looped():
	if action_info.is_wall_collision:
		wall_bounce()
	action_info.move_velocity.x -= initial_direction.x*12.0
	return action_info


func get_debug_name() -> String:
	return "Backup"
