extends KinematicBody

var gravity = -9.8
var velocity = Vector3(0, 0, 0)

const MAX_SPEED = 1
const ACCELERATION = 1
const DE_ACCELERATION = 5

func _ready():
	pass
	
func _physics_process(delta):
	if velocity.z < MAX_SPEED and velocity.z > -MAX_SPEED:
		if(Input.is_action_just_pressed("move_fw")):
			velocity.z -= ACCELERATION
		if(Input.is_action_just_pressed("move_bw")):
			velocity.z += ACCELERATION
	if(Input.is_action_just_pressed("move_left")):
		velocity.x += ACCELERATION
	if(Input.is_action_just_pressed("move_right")):
		velocity.x -= ACCELERATION
	velocity.y += delta * gravity
	velocity = move_and_slide(velocity, Vector3(0,-1,0))


func move_in_direction():
	pass