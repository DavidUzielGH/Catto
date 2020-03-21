extends Control

signal next_pressed;

var dialog

func _ready():
	get_node("Sprite").set_texture("Imagenes/Cutscene/"+get_parent().get_name()+".png")
	dialog = get_node("Dialog")
	start_cutscene(global.get_cutscene_level());

func _physics_process(delta):
	if(Input.is_action_just_pressed("interact")):
		emit_signal("next_pressed");
	
func start_cutscene(scene):
	dialog.start(scene)
	yield(dialog, "dialogue_ended")
	global.raise_cutscene_level()
	SceneChanger.change_scene(global.get_cutscene_level(), get_parent().get_name())