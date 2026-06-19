class_name ActionTackle extends Action

var dmg = 5.0

var can_damage = false


func enemy_bounce():
	wall_bounce()
	if can_damage:
		action_info.enemy_mech.mech_stats.damage(dmg)
		can_damage = false


func action_began():
	can_damage = true
	initial_direction = action_info.direction_to_enemy


func action_looped():
	#var rot_factor = initial_direction.angle_to(Vector2(-1,0))
	#var rot = info.mech.rotation
	
	if action_info.is_wall_collision:
		wall_bounce()
	if action_info.is_enemy_collision:
		enemy_bounce()
	
	action_info.move_velocity += initial_direction*12.0
	action_info.rot_velocity /= 2.0
	
	#info.mech.rotation = lerp(rot, rot_factor, .1)
	#
	#info.mech.scale.x = sign(info.enemy_mech.position.x - info.mech.position.x)


func get_debug_name() -> String:
	return "Tackle"
