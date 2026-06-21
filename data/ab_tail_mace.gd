extends AssemblyBehavior


func _ready():
	super._ready()
	for child in attachment.get_children():
		if child is RigidBody2D:
			child.freeze = true
	
