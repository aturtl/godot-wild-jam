class_name ActionTackle extends Action

var dmg = 5.0
var initial_direction = Vector2(0,0)

var can_damage = false


func enemy_bounce(info: ActionInfo):
	initial_direction = wall_bounce(info, initial_direction)
	if can_damage:
		info.enemy_mech.mech_stats.damage(dmg)
		can_damage = false


func action_began(info: ActionInfo) -> ActionInfo:
	can_damage = true
	initial_direction = info.direction_to_enemy
	return info


func action_looped(info: ActionInfo) -> ActionInfo:
	#var rot_factor = initial_direction.angle_to(Vector2(-1,0))
	#var rot = info.mech.rotation
	
	if info.is_wall_collision:
		initial_direction = wall_bounce(info, initial_direction)
	if info.is_enemy_collision:
		enemy_bounce(info)
	
	info.move_velocity += initial_direction*12.0
	info.rot_velocity /= 2.0
	
	#info.mech.rotation = lerp(rot, rot_factor, .1)
	#
	#info.mech.scale.x = sign(info.enemy_mech.position.x - info.mech.position.x)
	
	return info


func get_debug_name() -> String:
	return "Tackle"
