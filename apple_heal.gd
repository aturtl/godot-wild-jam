extends Node2D


func _physics_process(delta):
	position.y += .01
	modulate.a -= .01
	if modulate.a <= 0:
		queue_free()
