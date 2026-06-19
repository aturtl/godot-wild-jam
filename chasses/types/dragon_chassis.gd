extends Chassis


@onready var wing_sprite = $dragon_wings/Sprite


func mirror():
	if not is_node_ready():
		await ready
	print("FLIPPPENING")
	sprite.flip_h = true
	sprite.position.x *= -1
	sprite.rotation *= -1
	wing_sprite.position.x *= -1
	wing_sprite.get_parent().position.x *= -1
	wing_sprite.flip_h = true
