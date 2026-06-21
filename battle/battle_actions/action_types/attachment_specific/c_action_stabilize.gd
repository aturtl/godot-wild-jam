class_name ActionStabilize extends Action


func action_looped():
	action_info.rot_velocity *= .03
	action_info.mech.rotation *= .03


func get_debug_name() -> String:
	return "Stabilize"
