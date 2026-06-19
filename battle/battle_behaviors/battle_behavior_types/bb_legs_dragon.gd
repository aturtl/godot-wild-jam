class_name BBLegsDragon extends BattleBehavior


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionHover.new(), 0)
	mech_stats.add_modifier("air_spd", 2)
