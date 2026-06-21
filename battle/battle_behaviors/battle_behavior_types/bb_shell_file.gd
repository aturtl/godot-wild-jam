class_name BBShellFile extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionDuplicate.new(), 0)
	mech_stats.add_modifier("spd", 4)
	mech_stats.add_modifier("def", 2)
