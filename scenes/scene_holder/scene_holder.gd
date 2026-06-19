extends Node2D


@onready var scene: Node2D = $Scene
@onready var loading_screen: Node2D = $LoadingScreen

@onready var initial_scene: PackedScene = load("res://scenes/world/world.tscn")


func _ready():
	SceneLoader.scene_holder = scene
	SceneLoader.loading_screen = loading_screen
	SceneLoader.instantiate_scene_to_node(initial_scene, scene)
	SceneLoader.loading_screen_hide(.5)
