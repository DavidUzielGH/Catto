extends KinematicBody

var enter = false

var gravity = -50
var velocity = Vector3(0, 0, 0)
var going_idle = true
var camera
var curr_area
var new_area
var timer
const SPEED = .8
const MAX_SPEED = 2
const ACCELERATION = .5
const DE_ACCELERATION =30

const FRONT = 0
const BACK = 1

#COLLISION LAYERS
const DOORS = 3
func _ready():
	camera = self.get_parent().get_node("Camera").get_global_transform()
	
func _physics_process(delta):
	var dir = Vector3()
	if(enter == true and SceneChanger.is_inteact_disabled() == false):
		if(Input.is_action_just_pressed("interact")):
			global.set_previous_scene(self.get_parent().get_name())
			global.set_spawn(new_area)
			SceneChanger.change_scene(new_area, get_parent().get_name())
	if(Input.is_action_pressed("move_fw")):
		dir+=-camera.basis[2]
	if(Input.is_action_pressed("move_bw")):
		dir+=camera.basis[2]
	if(Input.is_action_pressed("move_left")):
		dir+=camera.basis[0]
	if(Input.is_action_pressed("move_right")):
		dir+=-camera.basis[0]
	if(Input.is_action_just_pressed("interact")):
		pass
	dir.y = 0
	dir = dir.normalized()
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
	if(area.get_collision_layer_bit(DOORS)):
		enter = true
		new_area = area.get_name()


func _on_Area_AreaDetection_exited(area):
	enter = false
	print(area.get_name())

signal timer_end

func _wait( seconds ):
	self._create_timer(self, seconds, true, "_emit_timer_end_signal")
	yield(self,"timer_end")

func _emit_timer_end_signal():
	emit_signal("timer_end")

func _create_timer(object_target, float_wait_time, bool_is_oneshot, string_function):
	timer = Timer.new()
	timer.set_one_shot(bool_is_oneshot)
	timer.set_timer_process_mode(0)
	timer.set_wait_time(float_wait_time)
	timer.connect("timeout", object_target, string_function)
	self.add_child(timer)
	timer.start()
