class_name Action extends Node


func action_began(info: ActionInfo) -> ActionInfo:
	return info


func action_looped(info: ActionInfo) -> ActionInfo:
	return info


func action_ended(info: ActionInfo) -> ActionInfo:
	return info


func wall_bounce(info: ActionInfo, direction: Vector2):
	direction.x = -direction.x
	info.move_velocity = -info.move_velocity
	info.g_velocity = Vector2(0, -200)
	info.rot_velocity /= 2.0
	return direction


func get_debug_name() -> String:
	return "Unnamed"
