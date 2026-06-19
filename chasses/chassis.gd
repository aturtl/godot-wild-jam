class_name Chassis extends Node2D

@onready var slots = $AttachmentSlots

func get_slot_count():
	return slots.get_children().size()

func get_slot_by_number(n):
	return slots.get_slot_by_number(n)

func enable_saving():
	for slot: AttachmentSlot in slots.get_children():
		slot.save_changes = true
