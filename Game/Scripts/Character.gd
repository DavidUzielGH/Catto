extends Node

var char_name
var scene_level
var actual_scene = 0
var room

func _ready():
	room = get_parent()

func set_name(nombre):
	char_name = nombre

func set_scene_level(nombre):
	global.get_character_scene_level(char_name)

func get_scene():
	return actual_scene

func set_scene(value):
	actual_scene = value