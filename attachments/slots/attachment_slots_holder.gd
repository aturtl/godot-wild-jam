extends Node2D

var size = 0

func _ready():
	for slot: AttachmentSlot in get_children():
		slot.number = size
		size += 1


func get_slot_by_number(n):
	for slot: AttachmentSlot in get_children():
		if slot.number == n:
			return slot
			
