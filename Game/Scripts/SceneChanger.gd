extends CanvasLayer

signal scene_changed()

var animation_player
var previous_scene = "Main"

func _ready():
	animation_player = get_node("Player")

func change_scene(path, prev, delay = 0.1):
	previous_scene = prev
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene("Escenas/Cuartos/"+path+".tscn") == OK)
	animation_player.play_backwards("Fade")
	emit_signal("scene_changed")

func get_previous_room():
	return previous_scene
