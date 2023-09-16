extends TextureRect
export var player : PackedScene


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Navigation2D/PlayerShip.landing = true
	

func _on_PlayerShip_player_exit():
	var player_scene = player.instance()
	player_scene.set_global_position(Vector2(22, 168))
	add_child(player_scene)
	player_scene.make_priority()
