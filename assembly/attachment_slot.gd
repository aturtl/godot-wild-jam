@tool

class_name AttachmentSlot extends Node2D

@export_enum("Head","Shell","Tail","Foot") var type: int;

func _process(delta):
	queue_redraw()

func _draw(): # editor visualization
	if Engine.is_editor_hint():
		var color: Color
		
		match type:
			0: color = Color.RED
			1: color = Color.GREEN
			2: color = Color.BLUE
			3: color = Color.PURPLE
		
		draw_circle(Vector2.ZERO,5.0,color)
