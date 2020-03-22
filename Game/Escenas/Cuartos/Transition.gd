extends Control

signal next_pressed;

var dialog

func _ready():
	dialog = get_node("Dialog")
	start_cutscene("1");

func _physics_process(delta):
	if(Input.is_action_just_pressed("interact")):
		emit_signal("next_pressed");
	if(Input.is_action_just_pressed("move_fw")):
		dialog.select("down")
	if(Input.is_action_just_pressed("move_bw")):
		dialog.select("up")
	
func start_cutscene(scene):
	dialog.start(scene)
	yield(dialog, "dialogue_ended")
	print("bromium")
	SceneChanger.change_scene("Vagon1-1", "Main")
