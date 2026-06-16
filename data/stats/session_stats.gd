extends Node

var default_stats: DefaultStats = DefaultStats.new()
var saved_stats: Resource
var stats: Resource

var save_path = "res://data/stats/save_stats.tres"

func _ready():
	if OS.is_debug_build():
		save_path = "res://data/stats/debug_stats.tres"
	
	load_stats()


func load_stats():
	stats = load(save_path)
	if not stats:
		print("No data found")
		stats = default_stats
	else:
		print("Data found", name, save_path)
	saved_stats = stats.duplicate()


func save_stats():
	saved_stats = stats
	ResourceSaver.save(saved_stats, save_path)
