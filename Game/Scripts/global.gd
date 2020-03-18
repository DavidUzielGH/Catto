extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scene_fade = false
var current_scene = null
var spawn_number = 0
var previous_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	
	call_deferred("_deferred_goto_scene", path)

func set_spawn(number):
	spawn_number = number

func set_previous_scene(name):
	previous_scene = name

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

func scene_faded():
	scene_fade = true
