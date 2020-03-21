extends KinematicBody

signal next_pressed
signal desition_made

var enter = false

var gravity = -10
var velocity = Vector3(0, 0, 0)
var going_idle = true
var camera
var new_area
var dialog_area = true
var interact = false
var dialog_box
var prev_room
var parent
var char_name

const SPEED = .8
const MAX_SPEED = 2
const ACCELERATION = .5
const DE_ACCELERATION =30

#COLLISION LAYERS
const ENVIROMENT = 0
const PEOPLE = 1
const INTERACABLES = 2
const DOORS = 3

func _ready():
	dialog_box = get_node("Dialog")
	camera = self.get_parent().get_node("Camera").get_global_transform()
	parent = get_parent()
	
func _physics_process(delta):
	var dir = Vector3()
	if(!dialog_box.is_on_dialogue):
		if(Input.is_action_just_pressed("interact")):
			if(enter == true and SceneChanger.is_interact_disabled() == false):
				SceneChanger.change_scene(new_area, get_parent().get_name())
			elif(dialog_area == true):
				var new_char = parent.get_node("Characters/"+char_name)
				dialog_box.start(str(new_char.get_scene()))
		if(Input.is_action_pressed("move_fw")):
			dir+=-camera.basis[2]
		if(Input.is_action_pressed("move_bw")):
			dir+=camera.basis[2]
		if(Input.is_action_pressed("move_left")):
			dir+=camera.basis[0]
		if(Input.is_action_pressed("move_right")):
			dir+=-camera.basis[0]
	elif(dialog_box.is_on_dialogue):
		if(Input.is_action_just_pressed("interact")):
			if(dialog_box.is_on_desition):
				emit_signal("desition_made")
			else:
				emit_signal("next_pressed")
		if(dialog_box.is_on_desition):
			if(Input.is_action_just_pressed("move_fw")):
				dialog_box.select("up")
			if(Input.is_action_just_pressed("move_bw")):
				dialog_box.select("down")
				
	dir.y = 0
	dir = dir.normalized()
	if(!self.is_on_floor()):
		velocity.y = delta * gravity
	var hv = velocity
	hv.y = 0
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))

	
func _on_Area_AreaDetection_entered(area):
	var parent_name = parent.get_name()
	if(area.get_collision_layer_bit(DOORS)):
		var area_name = area.get_name()
		if("-" in area.get_name() and SceneChanger.previous_scene != area_name and area_name.find(parent_name.substr(0, 5)) != -1):
			SceneChanger.previous_scene = parent_name
			SceneChanger.continue_room(area_name, SceneChanger.previous_scene)
		else:
			enter = true
			dialog_area = false
			interact = false
			new_area = area_name
	elif(area.get_collision_layer_bit(PEOPLE)):
		char_name = area.get_name()
		dialog_area = true
		enter = false
		interact = false
		

func _on_Area_AreaDetection_exited(area):
	var area_name = area.get_name()
	SceneChanger.previous_scene = get_parent().get_name()
	enter = false
	dialog_area = false
	interact = false
	print(area_name)
	

