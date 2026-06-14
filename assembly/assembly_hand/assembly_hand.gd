extends Node2D

@export var hand_default: Resource
@onready var interact_area: Area2D = $InteractArea

var mouse_just_pressed = true

func _ready():
	#Input.set_custom_mouse_cursor(hand_default) replace sprite and make more interactive
	pass

func _physics_process(delta):
	interact_area.position = get_global_mouse_position()
	if not GlobalData.selected_mouse_area and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if mouse_just_pressed:
			mouse_interact_check()
		mouse_just_pressed = false
	else:
		mouse_just_pressed = true

func mouse_interact_check():
	if GlobalData.selected_mouse_area:
		return
	var closest_area: Area2D
	var closest_dist: float = INF
	var mouse_pos = get_global_mouse_position()
	for area in interact_area.get_overlapping_areas():
		if area is DropArea and area.is_visible_in_tree():
			var dist: float = area.position.distance_to(mouse_pos)
			if dist < closest_dist:
				closest_dist = dist
				closest_area = area
	GlobalData.selected_mouse_area = closest_area
