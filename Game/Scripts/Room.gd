extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()
	pass # Replace with function body.

func spawn():
	print(SceneChanger.get_previous_room())
	var spawn_point = get_node("Node/"+SceneChanger.get_previous_room()+"/SpawnPoint")
	var preloadedPlayer = preload("res://Player.tscn")
	var player = preloadedPlayer.instance()
	player.transform.origin = spawn_point.transform.origin
	add_child(player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
