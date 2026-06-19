class_name BBTailTurtle extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.add_modifier("spd", 1)
