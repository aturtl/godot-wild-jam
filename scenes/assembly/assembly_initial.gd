extends Node2D


@onready var attachments_holder = $Attachments


func _ready():
	GlobalAssembly.attachments_holder = attachments_holder
	await SceneLoader.wait(3.7)
	SceneLoader.loading_screen_hide(.5)
