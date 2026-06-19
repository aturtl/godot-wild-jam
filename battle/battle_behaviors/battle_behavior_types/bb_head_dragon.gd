class_name BBHeadDragon extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionFirebreath.new(), 0)
	
