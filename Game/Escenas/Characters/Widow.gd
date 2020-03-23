extends "res://Scripts/Character.gd"


func _ready():
	pass

func _physics_process(delta):
	var machinist = global.get_character_scene_level("Machinist")
	var child = global.get_character_scene_level("Child")
	if(machinist == 3):
		set_scene(7)
	elif(machinist == 31):
		set_scene(8)
	elif(machinist == 31 and child == 211):
		set_scene(9)

