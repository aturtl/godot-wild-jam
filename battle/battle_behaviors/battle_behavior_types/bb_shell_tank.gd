class_name BBShellTank extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionExplosiveBullet.new(), 0)
	mech_stats.add_modifier("spd", -2)
	mech_stats.add_modifier("def", 6)
