class_name BBTailMace extends BattleBehavior


func on_creation():
	for chain in attachment.get_children():
		if chain is RigidBody2D:
			var s: Sprite2D = chain.get_node("Sprite")
			pass
			


func on_contact(): #not incl yet
	print("mech contacted")


func passive():
	print("mech passive") #swing speed determines damage


func modify_mech_stats(mech_stats: MechStats):
	mech_stats.append_action(ActionSwingMace.new(), 0)
	mech_stats.add_modifier("spd", -1)
	mech_stats.add_modifier("def", 2)
