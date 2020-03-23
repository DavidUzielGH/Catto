extends Control

signal next_pressed;
signal desition_made;

var dialog

func _ready():
	dialog = get_node("Dialog")
	start_cutscene("3");
	yield(dialog, "dialogue_ended")
	if(global.get_character_scene_level("Transition") == 1):
		SceneChanger.change_scene("Techo", "Transition")
	elif(global.get_character_scene_level("Transition") == 2):
		if(SceneChanger.previous_scene == "Vagon1"):
			SceneChanger.change_scene("Vagon2", "Transition")
		elif(SceneChanger.previous_scene == "Vagon2"):
			SceneChanger.change_scene("Vagon1", "Transition")
	elif(global.get_character_scene_level("Transition") == 3):
		if(SceneChanger.previous_scene == "Vagon1"):
			SceneChanger.change_scene("Vagon1", "Transition")
		elif(SceneChanger.previous_scene == "Vagon2"):
			SceneChanger.change_scene("Vagon2", "Transition")	
func _physics_process(delta):
	if(dialog.is_on_desition):
		if(Input.is_action_just_pressed("interact")):
			emit_signal("desition_made")
	else:
		if(Input.is_action_just_pressed("interact")):
			emit_signal("next_pressed");
	if(Input.is_action_just_pressed("move_fw")):
		dialog.select("up")
	if(Input.is_action_just_pressed("move_bw")):
		dialog.select("down")
	
func start_cutscene(scene):
	dialog.start(scene)
