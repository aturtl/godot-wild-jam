class_name Chassis extends Node2D

@onready var slots = $AttachmentSlots
@onready var sprite = $Sprite

func mirror():
	if not is_node_ready():
		await ready
	print("FLIPPPENING")
	sprite.flip_h = true
	sprite.position.x *= -1
	sprite.rotation *= -1

func get_slot_count():
	return slots.get_children().size()

func get_slot_by_number(n):
	return slots.get_slot_by_number(n)

func enable_saving():
	for slot: AttachmentSlot in slots.get_children():
		slot.save_changes = true
