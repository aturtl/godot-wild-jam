class_name BBShellApple extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionHeal.new(), 0)
	mech_stats.add_modifier("hp", 6)
	mech_stats.add_modifier("def", 1)
