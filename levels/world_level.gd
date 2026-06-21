class_name WorldLevel extends Control

@export var level_display = "?"
@export var name_display = "Unnamed Level"
@onready var button: TextureButton = $Button
var is_complete = false
var is_unlocked = false

var level: Level

@onready var sprite = $Button/Sprite

func _ready():
	await %WorldLevels.levels_loaded
	print(name, is_unlocked)


func walk_to_level():
	# menu here
	
	print("opening")
	
	
	%MapTurtle.walk_to_world_level(self)


func load_level_scene():
	SceneLoader.play_sound("res://sound/success.wav")
	LevelInfo.enemy_id = level.enemy_id
	LevelInfo.level_name = name
	if level.next_level:
		LevelInfo.next_level = level.next_level.name
	#level.location
	#get_tree().change_scene_to_file("res://scenes/battle/battle.tscn")
	SceneLoader.play_music("res://music/chainsaws.mp3", .5, -.3)
	SceneLoader.instantiate_file_with_loading_screen_shown("res://scenes/battle/battle.tscn")


func complete():
	unlock()
	is_complete = true
	if sprite:
		sprite.play("completed")


func unlock():
	button.button_down.connect(walk_to_level)
	is_unlocked = true
	if sprite:
		sprite.play("unlocked")


func lock():
	if sprite:
		sprite.play("locked")
