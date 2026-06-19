class_name ActionDuplicate extends Action

var redirect_time = 1.0
var clone_life_time = 5.0

var max_clones = 5
var current_clone_count = 0

var clones = []

var clone_dmg = 1.5


func action_began():
	while current_clone_count < max_clones:
		create_clone()
		current_clone_count += 1
	
	return action_info


func create_clone():
	var dup_mech: Mech = action_info.mech.duplicate()
	
	dup_mech.modulate = Color(.5,.5,.5,.7)
	
	dup_mech.collision_layer = 0
	dup_mech.collision_mask = 0b10001
	
	dup_mech.perform_gravity = false
	dup_mech.enemy = action_info.mech.enemy
	
	action_info.mech.get_parent().add_child(dup_mech)
	
	var life_timer = Timer.new()
	var redirect_timer = Timer.new()
	action_info.mech.add_child(life_timer)
	action_info.mech.add_child(redirect_timer)
	
	dup_mech.action_info.move_velocity = Vector2.from_angle(randf_range(0,2*PI)) * 444.0
	
	redirect_timer.start(redirect_time)
	life_timer.start(clone_life_time)
	
	redirect_timer.timeout.connect(redirect_clone.bind(redirect_timer,dup_mech))
	life_timer.timeout.connect(delete_clone.bind(life_timer,dup_mech))
	dup_mech.hit_wall.connect(bounce_clone.bind(dup_mech))
	dup_mech.hit_enemy.connect(clone_damage.bind(action_info.mech.enemy, dup_mech))


func clone_damage(enemy: Mech, clone: Mech):
	enemy.mech_stats.damage(clone_dmg)
	delete_clone(null, clone)


func bounce_clone(clone: Mech):
	clone.action_info.move_velocity = -clone.action_info.move_velocity


func redirect_clone(redirect_timer: Timer, clone: Mech):
	clone.action_info.move_velocity = clone.position.direction_to(clone.enemy.position) * 800.0
	redirect_timer.queue_free()


func delete_clone(life_timer: Timer, clone: Mech):
	if life_timer:
		life_timer.queue_free()
	if clone:
		clone.queue_free()
		current_clone_count -= 1


func get_debug_name() -> String:
	return "Duplicate"
