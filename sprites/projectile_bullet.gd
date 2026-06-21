class_name ProjectileBullet extends Node2D


@onready var bullet_scene = load("res://sprites/bullet.tscn").instantiate()
var sprite: AnimatedSprite2D


var dir: Vector2
var mag: float
var enemy: Mech


func _init(pos: Vector2, direction: Vector2, mag: float, enemy: Mech):
	self.dir = direction
	self.mag = mag
	self.enemy = enemy
	global_position = pos
	


func _ready():
	add_child(bullet_scene)
	sprite = bullet_scene.get_node("Sprite")
	sprite.rotation = Vector2(0,1).angle_to(dir) - PI/2.0
	sprite.play()
	add_child(sprite)


func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, position + dir*mag)
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.collision_mask = 0b1
	var result = space_state.intersect_ray(query)
	
	if result and result.collider:
		print("COLLISION")
		if result.collider == enemy:
			print("ENEMY COLLISION")
			enemy.mech_stats.damage(4.0)
		sprite.play("burst")
		
		queue_free()
	
	position += dir*mag
