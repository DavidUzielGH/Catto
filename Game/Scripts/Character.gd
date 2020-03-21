extends Node

var char_name
var scene_level
var room

func _ready():
	room = get_parent()
	global.get_scene(char_name)

func set_name(nombre):
	char_name = nombre

func set_scene_level(nombre):
	global.get_character_scene_level(char_name)
