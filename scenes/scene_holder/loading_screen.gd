extends Node2D


@onready var slider: Control = $Slider


func follow_camera():
	var cam = get_viewport().get_camera_2d()
	if cam:
		position = cam.position - get_viewport_rect().size/2.0


func _physics_process(delta):
	#follow_camera()
	pass
