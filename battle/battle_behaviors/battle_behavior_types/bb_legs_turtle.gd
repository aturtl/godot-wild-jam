class_name BBLegsTurtle extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionStabilize.new(), 0)
	mech_stats.add_modifier("spd", 1)
