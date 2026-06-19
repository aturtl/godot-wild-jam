extends Node2D


@onready var levels_holder = load("res://levels/levels.tscn").instantiate()


func _ready():
	for world_level: WorldLevel in get_children():
		var level: Level = levels_holder.find_child(world_level.name)
		if level:
			world_level.level = level
			if check_level_completion(level):
				world_level.complete()
			elif check_level_unlocked(level):
				world_level.unlock()
			else:
				world_level.lock()


func check_level_completion(level: Level):
	return level.name in SESSIONSTATS.default_stats.completed_levels


func check_level_unlocked(level: Level):
	return level.name in SESSIONSTATS.stats.unlocked_levels
