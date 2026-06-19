extends Node


var scene_holder: Node2D
var loading_screen: Node2D

var scene_path = ""


func get_scene_holder():
	return scene_holder


func reload_scene_holder():
	instantiate_file_to_scene_holder(scene_path)


func instantiate_scene_to_node(scene: PackedScene, parent: Node, top_level:bool = true, clear_node:bool = true):
	if clear_node:
		for child in parent.get_children():
			scene_holder.remove_child(child)
			child.queue_free()
	var instantiated = scene.instantiate()
	if top_level:
		instantiated.top_level = true
	parent.add_child(instantiated)


func instantiate_file_to_scene_holder(file_path):
	scene_path = file_path
	instantiate_scene_to_node(load(file_path), scene_holder)


func loading_screen_hide(t: float):
	var tween = get_tree().create_tween()
	tween.tween_property(loading_screen.slider, "position", Vector2(0, -920), t)
	tween.play()
	await tween.finished


func loading_screen_show(t: float):
	var tween = get_tree().create_tween()
	tween.tween_property(loading_screen.slider, "position", Vector2(0, 0), t)
	tween.play()
	await tween.finished


func loading_screen_set_time(initial: float, pause: float, end: float):
	await loading_screen_show(initial)
	await wait(pause)
	await loading_screen_hide(end)


func loading_screen_set_time_with_callback(callback: Callable, initial: float, pause: float, end: float):
	await loading_screen_show(initial)
	callback.call()
	await wait(pause)
	await loading_screen_hide(end)


func instantiate_file_with_loading_screen(file_path):
	loading_screen_set_time_with_callback(instantiate_file_to_scene_holder.bind(file_path),.5,.2,.5)


func wait(t: float):
	await get_tree().create_timer(t).timeout
