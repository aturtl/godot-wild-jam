class_name ActionDodge extends Action


func action_began():
	return action_info


func action_looped():
	action_info.move_velocity -= action_info.direction_to_enemy*3.0
	action_info.move_velocity.y = 10.0
	action_info.move_velocity += Vector2(randf_range(-5.0,5.0),randf_range(-5.0,5.0))
	action_info.rot_velocity += action_info.direction_to_enemy.dot(Vector2(0,1))*.005
	return action_info


func get_debug_name() -> String:
	return "Dodge"
