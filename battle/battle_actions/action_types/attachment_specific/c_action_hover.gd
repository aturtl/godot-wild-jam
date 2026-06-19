class_name ActionHover extends Action

var hover_speed: float = 125

var correction_amount: float = .07

func action_began():
	return action_info


func action_looped():
	var rot:float = action_info.mech.rotation
	
	rot = lerp(rot, 0.0, correction_amount)
	
	var dir = Vector2.from_angle(rot-PI/2)
	
	action_info.jump_velocity = dir*hover_speed
	action_info.move_velocity = Vector2.ZERO
	action_info.rot_velocity /= 2.0
	action_info.g_velocity.y = 0
	
	action_info.mech.rotation = rot
	
	return action_info


func get_debug_name() -> String:
	return "Hover"
