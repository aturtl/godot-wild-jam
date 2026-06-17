extends Node2D

@export var frames_between_switch = 20
var frames = 0

@export var anim_frame_count = 2
var current_anim_frame = 0

@onready var sprite:Sprite2D = get_parent().find_child("Sprite")

@export var enabled = false

func _ready():
	var p = get_parent()
	if p is Attachment and p.type == p.Type.ASSEMBLY:
		enabled = true

func _physics_process(delta):
	if !enabled:
		return
	
	frames += 1
	frames %= frames_between_switch
	if frames == 0:
		current_anim_frame += 1
		current_anim_frame %= anim_frame_count
		sprite.frame_coords.x = current_anim_frame
