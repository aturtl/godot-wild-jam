class_name BBHeadTurtle extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionChomp.new(), 0)
