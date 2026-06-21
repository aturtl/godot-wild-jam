class_name AssemblyBehavior extends Node2D

var dragging: bool = false
var drag_offset: Vector2

@onready var attachment: Attachment = get_parent()
@onready var drop_area: DropArea = attachment.drop_area
@onready var control_marker: Control = attachment.control_marker

var list_size = Vector2(.5,.5)
var drag_size = Vector2(.7,.7)


func _ready():
	attachment.visible = true


func _physics_process(delta):
	manage_dragging_and_dropping()


func manage_dragging_and_dropping():
	var was_dragging = dragging
	
	dragging = (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and GlobalData.selected_mouse_area == drop_area)
	
	if !was_dragging and dragging: # determine offset
		drag_start()
	
	if dragging:
		drag()
	
	if was_dragging and !dragging:
		GlobalData.selected_mouse_area = null
		drop()
	
	if !dragging and !attachment.attached and control_marker:
		lock_to_control_marker()


func lock_to_control_marker():
	if attachment.get_parent() != control_marker:
		attachment.reparent(control_marker)
	attachment.scale = list_size
	attachment.global_position = control_marker.global_position + control_marker.size/2.0 - attachment.get_node("Center").position*list_size


func drag_start():
	drag_offset = get_global_mouse_position() - attachment.global_position
	attachment.reparent(GlobalAssembly.attachments_holder)


func drag():
	attachment.rotation = 0
	attachment.scale = drag_size
	attachment.global_position = get_global_mouse_position() - drag_offset


func drop():
	var slot = attachment.get_slot()
	if slot:
		attachment.attach(slot)
	else:
		attachment.detach()
		attachment.reparent(control_marker)
		print("reparent")
		
