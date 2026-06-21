class_name MechStats extends Node

var actions = [
	#ActionIdle.new(),
	#ActionDodge.new(),
	#ActionJump.new(),
	ActionJumpAt.new(),
	ActionBackup.new(),
	#ActionRandomDirection.new(),
	ActionTackle.new()
]

var base_modifiers = {
	hp = 10.0,
	def = 5.0,
	spd = 8.0,
	air_spd = 6.0,
}

var attachment_behaviors = []

var equipped_attachments = []
var equipped_chassis: Chassis

var health_bar: HealthBar

signal death

func append_action(action, weight): #weight unused currently
	actions.append(action)


func calculate_speed_multiplier(floored: bool):
	var spd = base_modifiers.spd if floored else base_modifiers.air_spd
		
	return (spd-8)/6+1


func calculate_damage(dmg: float) -> float:
	var b = base_modifiers
	return dmg/(b.def*.2)


func damage(dmg: float):
	base_modifiers.hp -= calculate_damage(dmg)
	health_bar.current_health = base_modifiers.hp
	health_bar.update()
	if base_modifiers.hp <= 0:
		emit_signal("death")


func add_modifier(nm: String, value: float):
	if nm in base_modifiers:
		base_modifiers[nm] += value


func get_modifier(nm: String):
	if nm in base_modifiers:
		return max(1, base_modifiers[nm]) # makes sure that the stat remains at least 1
