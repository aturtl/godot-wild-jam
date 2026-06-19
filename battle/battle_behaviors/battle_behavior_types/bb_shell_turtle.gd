class_name BBShellTurtle extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionTuck.new(), 0)
	mech_stats.add_modifier("def", 4)
