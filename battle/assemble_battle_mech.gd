class_name MechSetup extends Node2D

@onready var attachments_data = load("res://data/attachments_data.tscn").instantiate()

var mech: Mech = Mech.new()
var mech_stats: MechStats = MechStats.new()

var spawn_position = position

var is_player: bool
var id = "debug_enemy1"

var chassis_name = ""
var equipped_attachments = []

var attach_behaviors = true

@onready var enemy_data_path = "res://data/enemy_data/enemy_data.json"
var e_data_json: Dictionary

func setup_mech() -> Mech:
	if is_player:
		get_player_info()
	else:
		setup_e_data_json()
		get_enemy_info()
	
	load_chassis()
	load_equipped_attachments()
	
	mech.set_stats(mech_stats)
	parent_mech_items()
	return mech


func setup_e_data_json():
	var file = FileAccess.open("res://data/enemy_data/enemy_data.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	e_data_json = data


func get_player_info():
	chassis_name = SESSIONSTATS.stats.equipped_chassis
	
	var i = 0
	for attachment_array in SESSIONSTATS.stats.owned_attachments:
		var attached_to = attachment_array[1]
		if attached_to != -1:
			print("PLAYER: attaching", attachment_array)
			equipped_attachments.append(attachment_array)
		i += 1


func get_enemy_info():
	if !(id in e_data_json):
		print("ID NOT FOUND")
		return
	chassis_name = e_data_json[id]["chassis"]
	equipped_attachments = e_data_json[id]["attachments"]


func load_chassis():
	var ec: Chassis = load("res://chasses/types/"+chassis_name+".tscn").instantiate()
	mech.add_child(mech_stats.equipped_chassis)
	mech_stats.equipped_chassis = ec


func load_equipped_attachments():
	await mech_stats.equipped_chassis.ready
	
	var i = 0
	
	for attachment_array in equipped_attachments:
		var attachment = attachments_data.find_child(attachment_array[0])
		var attachment_name = attachment_array[0]
		var attached_to = attachment_array[1]
		if attachment and attachment is Attachment and attached_to <= mech_stats.equipped_chassis.get_slot_count() - 1:
			var dup_attachment:Attachment = attachment.duplicate()
			dup_attachment.id_name = attachment_name
			dup_attachment.owned_index = i
			dup_attachment.type = dup_attachment.Type.BATTLE
			
			mech_stats.equipped_attachments.append(dup_attachment)
			
			if attach_behaviors:
				set_behavior_from_attachment(dup_attachment)
			
			dup_attachment.add_collision_exception_with(mech)
			dup_attachment.attach(mech_stats.equipped_chassis.get_slot_by_number(attached_to))
		i += 1


func set_behavior_from_attachment(dup_attachment):
	dup_attachment.add_battle_behavior()
	dup_attachment.battle_behavior.modify_mech_stats(mech_stats)
	mech_stats.attachment_behaviors.append(dup_attachment.battle_behavior)
	mech_stats.equipped_chassis.add_child(dup_attachment)


func parent_mech_items():
	mech.add_child(mech_stats.equipped_chassis)
	var cc = mech_stats.equipped_chassis.find_child("ChassisCollision")
	cc.name = "CC"
	if cc:
		cc.reparent(mech)
		mech.chassis_collision = cc
