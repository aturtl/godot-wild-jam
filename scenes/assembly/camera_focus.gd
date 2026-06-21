class_name CameraFocus extends Node2D

@export var zoom: Vector2 = Vector2(1,1)

@onready var c = SceneLoader.get_camera() 

func _ready():
	c.follow(self)
	c.set_global_zoom(zoom)
	
func set_zoom(amount: Vector2):
	c.set_global_zoom(amount)
