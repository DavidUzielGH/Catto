extends "res://Scripts/Character.gd"


func _ready():
	pass

func _physics_process(delta):
	var machinist = global.get_character_scene_level("Machinist")
	var child = global.get_character_scene_level("Child")
	var widow = global.get_character_scene_level("Widow")
	if(machinist == 3):
		set_scene(7)
	elif(machinist == 31 and child != 211 and widow != 91):
		set_scene(8)
	elif(widow == 91):
		set_scene(91)
	elif(machinist == 31 and child == 211):
		set_scene(9)
	elif(widow == 101):
		set_scene(101)
	elif(child == 221):
		set_scene(10)

