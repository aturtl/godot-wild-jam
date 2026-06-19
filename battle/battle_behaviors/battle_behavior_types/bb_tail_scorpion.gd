class_name BBTailScorpion extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionWhip.new(), 0)
	mech_stats.add_modifier("spd", -2)
