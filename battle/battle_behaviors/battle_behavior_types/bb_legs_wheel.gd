class_name BBLegsWheel extends BattleBehavior


func passive():
	pass #grounded


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.add_modifier("spd", 3)
