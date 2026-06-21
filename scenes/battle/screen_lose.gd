class_name LoseScreen extends Control


var is_active = false

@onready var cover = $Cover
@onready var buttons = $Buttons
@onready var btn_return: TextureButton = buttons.get_node("Return")
@onready var btn_again: TextureButton =  buttons.get_node("Again")

func _ready():
	#visible = false
	cover.position.y = -900
	buttons.position.y = 648
	pass


func try_again():
	SceneLoader.play_music("res://music/chainsaws.mp3", .5, -.3)
	SceneLoader.instantiate_file_with_loading_screen_shown("res://scenes/battle/battle.tscn")


func return_home():
	SceneLoader.play_sound("res://sound/selection.wav")
	SceneLoader.play_music("res://music/sunshine.mp3")
	SceneLoader.instantiate_file_with_loading_screen("res://scenes/world/world.tscn")


func btn_tween(btn):
	var tween = create_tween()
	tween.tween_property(btn, "position:y", -128, .7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.play()


func activate():
	btn_return.button_down.connect(return_home)
	btn_again.button_down.connect(try_again)
	
	print("Win Screen Activated")
	visible = true
	var screen_pos_tween = create_tween()
	var screen_rot_tween = create_tween()
	

	screen_pos_tween.tween_property(cover, "position", Vector2(0,0), 1.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	screen_pos_tween.play()
	await get_tree().create_timer(.2).timeout
	screen_rot_tween.play()
	
	await get_tree().create_timer(.05).timeout
	btn_tween(btn_return)
	
	await get_tree().create_timer(.1).timeout
	btn_tween(btn_again)
	
	print("finished")
	pass


func _physics_process(delta):
	if is_active:
		pass
