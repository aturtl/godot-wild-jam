extends Node2D


func _ready():
	await SceneLoader.wait(3.7)
	SceneLoader.loading_screen_hide(.5)
