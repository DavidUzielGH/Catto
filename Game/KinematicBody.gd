extends KinematicBody

var gravity = -50
var velocity = Vector3(0, 0, 0)
var going_idle = true
var camera

const SPEED = .8
const MAX_SPEED = 2
const ACCELERATION = .5
const DE_ACCELERATION =30

func _ready():
	camera = get_node("../../Camera").get_global_transform()
	
func _physics_process(delta):
	var dir = Vector3()
	if(Input.is_action_pressed("move_fw")):
		dir+=-camera.basis[2]
	if(Input.is_action_pressed("move_bw")):
		dir+=camera.basis[2]
	if(Input.is_action_pressed("move_left")):
		dir+=camera.basis[0]
	if(Input.is_action_pressed("move_right")):
		dir+=-camera.basis[0]
	dir.y = 0
	dir = dir.normalized()
	velocity.y = delta * gravity
	var hv = velocity
	hv.y = 0
	var new_pos = dir * SPEED
	print(new_pos)
	var accel = DE_ACCELERATION
	
	#if(dir.dot(hv) < 0):
	#	accel = ACCELERATION
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
