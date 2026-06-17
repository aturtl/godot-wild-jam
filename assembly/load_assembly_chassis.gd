extends Node2D

func _ready():
	var equipped_chassis_name = SESSIONSTATS.stats.equipped_chassis
	var ec = load("res://chasses/types/"+equipped_chassis_name+".tscn").instantiate()
	
	if ec:
		await add_child(ec)
	
	if equipped_chassis_name == "ant_chassis":
		ec.scale = Vector2(1.8,1.8)
	
	%AttachmentsManager.initial_setup()
