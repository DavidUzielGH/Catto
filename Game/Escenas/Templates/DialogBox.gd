extends CanvasLayer

signal next_pressed
signal dialogue_ended

var data : Dictionary
var scene :Dictionary

var char_name
var is_on_dialogue = false
var dialog
var left_portrait
var right_portrait
var control
var visible = false
var parent

const LEFT = "left"
const RIGHT = "right"

func _ready():
	control = get_node("Control")
	left_portrait = get_node("Control/Left")
	right_portrait = get_node("Control/Right")
	char_name = get_node("Control/Name/Label")
	dialog = get_node("Control/Dialog/RichTextLabel")
	parent = get_parent()
	control.hide()

func start(scene_number : String):
	is_on_dialogue = true
	toggle_visibility()
	var data_file = File.new()
	if data_file.open("res://Dialogo.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	data = data_parse.result
	scene = data[scene_number]
	for i in range(scene.size()):
		var index = str(i)
		set_name(scene[index].get("name"))
		set_dialogue(scene[index].get("dialogue"))
		set_portrait(""+scene[index].get("portrait")+".png", scene[index].get("side"))
		yield(parent, "next_pressed")
	end_scene()

func end_scene(): 
	toggle_visibility()
	is_on_dialogue = false

func set_name(set_name):
	char_name.set_text(set_name)

func set_dialogue(dialogue):
	dialog.set_text(dialogue)

func set_portrait(picture, side):
	if(side == LEFT):
		left_portrait.texture = load("Imagenes/Jugador/"+picture)
		right_portrait.texture = null
	if(side == RIGHT):
		right_portrait.texture = load("Imagenes/Jugador/"+picture)
		left_portrait.texture = null

func toggle_visibility():
	visible = !visible
	control.set_visible(visible)
