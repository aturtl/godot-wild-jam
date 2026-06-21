extends Node2D

@export var mech_scale = .5

@export var display_action_statuses = false

@onready var p_mech_setup = MechSetup.new()
@onready var e_mech_setup = MechSetup.new()

@export var p_spawnpoint: Spawnpoint
@export var e_spawnpoint: Spawnpoint

var p_mech: Mech
var e_mech: Mech

@export var p_healthbar: HealthBar
@export var e_healthbar: HealthBar

@export var win_screen: WinScreen
@export var lose_screen: LoseScreen

var winner: String = ""

@export var instant_win = false
@export var instant_lose = false

@export var screen_shake: Sprite2D

@export var camera_focus: CameraFocus

var shake_amount: int = 0

var last_zoom_factor = Vector2(1.0,1.0)
var max_zoom_factor = Vector2(1.2,1.2)
var zoom_scale = .6

func _ready():
	read_level_info()

	build_mechs()
	setup_displays()
	
	spawn_mechs()
	
	await SceneLoader.wait(4.0)
	await SceneLoader.loading_screen_hide(.5)
	
	start_battle()
	
	if display_action_statuses:
		p_mech.action_changed.connect(_debug_p_action_changed)
		e_mech.action_changed.connect(_debug_e_action_changed)


func _physics_process(delta):
	if camera_focus:
		camera_focus.position = camera_focus.position.lerp((p_mech.position+e_mech.position)/2.0+Vector2.UP*100.0,.045)
		var zoom_factor = 1/(abs(p_mech.position.x-e_mech.position.x)/get_viewport_rect().size.x)
		zoom_factor *= zoom_scale
		var lerped_zoom_factor = last_zoom_factor.lerp(Vector2.ONE*zoom_factor, .02)
		lerped_zoom_factor = lerped_zoom_factor.min(max_zoom_factor)
		camera_focus.set_zoom(lerped_zoom_factor)
		last_zoom_factor = lerped_zoom_factor
	
	if shake_amount > 0:
		shake_amount = max(0,shake_amount - 1)
		screen_shake.material.set("shader_parameter/intensity",shake_amount)


func read_level_info():
	e_mech_setup.id = LevelInfo.enemy_id


func start_battle():
	activate_mechs()
	
	if instant_win:
		e_mech.mech_stats.damage(10000000)
	if instant_lose:
		p_mech.mech_stats.damage(10000000)


func setup_displays():
	p_healthbar.track_health(p_mech)
	e_healthbar.track_health(e_mech)
	p_healthbar.displayed = true
	e_healthbar.displayed = true


func build_mechs():
	p_mech_setup.mirrored = true
	
	p_mech_setup.is_player = true
	
	p_mech = create_mech(p_mech_setup, p_spawnpoint.position)
	e_mech = create_mech(e_mech_setup, e_spawnpoint.position)
	
	p_mech.death.connect(on_p_death)
	e_mech.death.connect(on_e_death)
	
	p_mech.hit_enemy.connect(on_p_hit_enemy)
	p_mech.hit_enemy.connect(on_p_hit_wall)
	
	p_mech.name = "PlayerMech"
	e_mech.name = "EnemyMech"
	
	p_mech.enemy = e_mech
	e_mech.enemy = p_mech
	
	p_mech.scale = Vector2(mech_scale,mech_scale)
	e_mech.scale = Vector2(mech_scale,mech_scale)


func spawn_mechs():
	add_child(p_mech)
	add_child(e_mech)


func activate_mechs():
	p_mech.activate()
	e_mech.activate()


func create_mech(setup: MechSetup, spawnpoint: Vector2):
	add_child(setup)
	var mech = setup.setup_mech()
	mech.position = spawnpoint
	
	return mech


func _debug_p_action_changed(action_name):
	%PlayerActionsDebug.text = "Player Action: " + action_name


func _debug_e_action_changed(action_name):
	%EnemyActionsDebug.text = "Enemy Action: " + action_name


func player_won():
	display_win_screen()
	SESSIONSTATS.stats.completed_levels.append(LevelInfo.level_name)
	SESSIONSTATS.save_stats()


func player_lost():
	display_lose_screen()
	pass


func display_win_screen():
	win_screen.activate()
	pass


func display_lose_screen():
	lose_screen.activate()
	pass


func wall_shake():
	shake_amount = 5.0


func on_p_hit_enemy():
	wall_shake()


func on_p_hit_wall():
	wall_shake()


func on_p_death():
	e_mech.death.disconnect(on_e_death)
	p_mech.death.disconnect(on_p_death)
	player_lost()
	print("LOSE")


func on_e_death():
	e_mech.death.disconnect(on_e_death)
	p_mech.death.disconnect(on_p_death)
	player_won()
	print("WIN")
