extends Node

var char_name
var scene 

func _ready():
	global.get_scene(char_name)

func set_name(nombre):
	char_name = nombre
