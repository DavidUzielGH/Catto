extends CanvasLayer

signal dialogue_ended

var data : Dictionary
var scene :Dictionary
var new_key : Dictionary

var end_reached = false
var char_name
var desition_options = 0
var is_on_dialogue = false
var is_on_desition = false
var dialog
var left_portrait
var right_portrait
var control
var visible = false
var parent
var curr_branch = "Branch0"
var desition
var selected_desition = 0
var desition_texts = {1:"", 2:"", 3:"", 4:""}
const LEFT = "left"
const RIGHT = "right"
const NOTHING = ""

func _ready():
	control = get_node("Control")
	left_portrait = get_node("Control/Left")
	right_portrait = get_node("Control/Right")
	char_name = get_node("Control/Name/Label")
	dialog = get_node("Control/Dialog/RichTextLabel")
	desition = get_node("Control/Desition")
	parent = get_parent()
	control.hide()

func start(scene_number : String):
	is_on_dialogue = true
	toggle_visibility()
	get_node("Control/Desition").hide()
	end_reached = false
	var data_file = File.new()
	if data_file.open("res://Dialogo.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	data = data_parse.result
	scene = data["Scene"+scene_number]
	while(end_reached == false):
		for key in scene[curr_branch].keys():
			if(key == "Event"):
				global.set_character_scene_level(scene[curr_branch].get(key).get("Name"), scene[curr_branch].get(key).get("Level"))
			elif(key == "Choice"):
				desition_options = 0
				desition_options = scene[curr_branch].get("Choice").keys().size()
				for key in scene[curr_branch].get("Choice").keys():
					desition_texts[key] = scene[curr_branch].get("Choice").get(key).get("Head")
				set_desition_box();
				is_on_desition = true
				play_anim(0)
				yield(parent, "desition_made")
				curr_branch = scene[curr_branch].get("Choice").get("Option"+str(selected_desition)).get("Tail") 
				end_desition()			
			elif(key == "End"):
				end_reached = true
			else:
				set_name(scene[curr_branch].get(key).get("name"))
				set_dialogue(scene[curr_branch].get(key).get("dialogue"))
				set_portrait(scene[curr_branch].get(key).get("name")+"/"+scene[curr_branch].get(key).get("portrait")+".png", scene[curr_branch].get(key).get("side"))
				yield(parent, "next_pressed")
	end_scene()
	
func end_scene(): 
	emit_signal("dialogue_ended")
	toggle_visibility()
	is_on_dialogue = false
	curr_branch = "Branch0"

func end_desition():
	hide_desition_boxes()
	is_on_desition = false

func set_name(set_name):
	char_name.set_text(set_name)

func hide_desition_boxes():
	desition.hide()
	desition.get_node("0").hide()
	desition.get_node("1").hide()
	desition.get_node("2").hide()
	desition.get_node("3").hide()

func set_desition_box():
	desition.show()
	for i in range(desition_options):
		desition.get_node(str(i)).show()
		desition.get_node(str(i)+"/Text").set_text(desition_texts["Option"+str(i)])

func set_dialogue(dialogue):
	dialog.set_text(dialogue)

func set_portrait(path, side):
	if(side == LEFT):
		left_portrait.texture = load("Imagenes/Portraits/"+path)
		right_portrait.texture = null
	if(side == RIGHT):
		right_portrait.texture = load("Imagenes/Portraits/"+path)
		left_portrait.texture = null

func select(direction):
	if(direction == "up" and selected_desition != 0):
		selected_desition-=1
	elif(direction == "down" and selected_desition != desition_options-1):
		selected_desition+=1
	print(selected_desition)
	desition.get_node(str(selected_desition))
	play_anim(selected_desition)
	
func play_anim(number):
	desition.get_node("0/AnimationPlayer").stop(true)
	desition.get_node("1/AnimationPlayer").stop(true)
	desition.get_node("2/AnimationPlayer").stop(true)
	desition.get_node("3/AnimationPlayer").stop(true)
	desition.get_node(str(number)+"/AnimationPlayer").play("Glow")

func toggle_visibility():
	visible = !visible
	control.set_visible(visible)
	
