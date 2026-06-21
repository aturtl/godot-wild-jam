class_name ActionExplosiveBullet extends Action


var bullet_frame = 30
var elapsed_frames = 0

func action_looped():
	elapsed_frames += 1
	elapsed_frames %= bullet_frame
	var mech = action_info.mech
	var enemy = action_info.enemy_mech
	if elapsed_frames == 0:
		var proj_holder = GlobalBattle.battle_holder.get_node("Projectiles")
		var dir = mech.position.direction_to(enemy.position)
		var proj = ProjectileBullet.new(mech.global_position + dir*12.0, dir, 80.0, enemy)
		proj_holder.add_child(proj)
		SceneLoader.play_sound("res://sound/firebreath2.wav", 0, 4.0)


func get_debug_name() -> String:
	return "Explosive Bullet"
