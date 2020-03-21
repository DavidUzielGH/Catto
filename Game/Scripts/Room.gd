extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var preloadedPlayer 
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()
	preloadedPlayer = preload("res://Player.tscn")
	player = preloadedPlayer.instance()
	pass # Replace with function body.

func spawn():
	var spawn_point = get_node("DoorsSpawns/"+SceneChanger.get_previous_room()+"/SpawnPoint")
	preloadedPlayer = preload("res://Player.tscn")
	player = preloadedPlayer.instance()
	player.transform.origin = spawn_point.transform.origin
	add_child(player)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_player_scale(multiplicator):
	player.set_scale(Vector3(10, 10, 10))
	print("bru")

func get_player():
	return player
