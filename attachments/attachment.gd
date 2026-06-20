class_name Attachment extends AnimatableBody2D

@export var control_marker: Control
@export var z_index_override: int = -1

@onready var drop_area: Area2D = $DropArea
@onready var connect_to_info = $ConnectTo
@onready var sprite = $Sprite
@onready var back_sprite = $Sprite2

var battle_behavior: BattleBehavior
@export var assembly_behavior: AssemblyBehavior

var mirrored = false

enum Type {
	UNASSIGNED,
	ASSEMBLY,
	BATTLE
}

enum BodyParts {
	Head,
	Shell,
	Tail,
	Foot
}

var type = Type.UNASSIGNED

var id_name: String
var owned_index: int

# ASSEMBLY

var attached: bool = false

signal detached

func _ready():
	add_behaviors()
	
	var c = connect_to_info.connect_to
	var b = BodyParts
	
	if z_index_override == -1:
		match (c):
			b.Foot:
				sprite.z_index = 12
			b.Shell:
				sprite.z_index = 10
			b.Head:
				sprite.z_index = 11
			b.Tail:
				sprite.z_index = 9
	else:
		z_index = z_index_override


func add_behaviors():
	if type == Type.BATTLE:
		add_battle_behavior()
	elif type == Type.ASSEMBLY:
		add_assembly_behavior()
		
		
func add_battle_behavior():
	if !battle_behavior:
		for child in get_children():
			if child is BattleBehavior:
				battle_behavior = child
		if !battle_behavior:
			battle_behavior = BattleBehavior.new()
			add_child(battle_behavior)
	battle_behavior.attachment = self


func add_assembly_behavior():
	if !assembly_behavior:
		assembly_behavior = AssemblyBehavior.new()
		add_child(assembly_behavior)


func replace_slot(slot: AttachmentSlot):
	slot.set_new_attachment(self)


func attach(slot: AttachmentSlot):
	if not slot:
		return
	attached = true
	replace_slot(slot)
	global_position = slot.global_position
	rotation = slot.rotation
	global_scale = slot.global_scale
	if mirrored:
		position.x *= -1
		rotation *= -1
		sprite.position.x *= -1
		sprite.flip_h = true
		if back_sprite:
			back_sprite.position.x *= -1
			back_sprite.flip_h = true
	visible = true
	


func detach():
	attached = false
	detached.emit()
	rotation = 0
	scale = Vector2(1,1)


func get_slot() -> AttachmentSlot:
	for area in drop_area.get_overlapping_areas():
		if area is SlotArea:
			if connect_to_info.connect_to == area.get_parent().type:
				SceneLoader.play_sound("res://sound/success.wav")
				return area.get_parent()
	SceneLoader.play_sound("res://sound/drop2.wav", 0.0, 6)
	return null
