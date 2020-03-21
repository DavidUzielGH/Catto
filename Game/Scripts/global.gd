extends Node

onready var char_level = {"Maria":0, "Fifi":0, "Niño":0, "Escritor":0, "Maquinista":0}
onready var room_level = {"Vagon1":0, "Techo1":0, "CosaNegra":0, "Techo3":0, "Vagon3":0, "Grua":0, "TechoGrua":0, "Techo4":0, "Caldera":0}
onready var cut_level = 0

func set_character_scene_level(character, level):
	char_level[character] = int(level)
	print("ernivel"+str(char_level[character]))

func get_character_scene_level(character):
	return char_level[character]

func get_room_level(room):
	return room_level[room]

func raise_room_level(room):
	room_level[room]+=1

func get_cutscene_level():
	return "Cutscene"+cut_level

func raise_cutscene_level():
	cut_level += 1
