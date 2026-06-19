class_name ActionRandomDirection extends Action

func wall_bounce():
	if action_info.is_wall_collision:
		initial_direction.x = -initial_direction.x
		action_info.move_velocity = -action_info.move_velocity
		action_info.rot_velocity /= 2.0


func action_began():
	initial_direction = Vector2(randf(),randf()).normalized()


func action_looped():
	wall_bounce()
	action_info.move_velocity += initial_direction * 5.0
	action_info.rot_velocity += initial_direction.dot(Vector2(0,1))*.001


func get_debug_name() -> String:
	return "Random"
