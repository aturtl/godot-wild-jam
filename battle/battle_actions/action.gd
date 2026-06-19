class_name Action extends Node


var action_info: ActionInfo
var initial_direction: Vector2


func action_began():
	pass


func action_setup(info: ActionInfo):
	action_info = info


func action_looped():
	pass


func action_ended():
	pass


func wall_bounce():
	initial_direction.x = -initial_direction.x
	action_info.move_velocity = -action_info.move_velocity
	action_info.g_velocity = Vector2(0, -600)
	action_info.rot_velocity /= 2.0


func get_debug_name() -> String:
	return "Unnamed"
