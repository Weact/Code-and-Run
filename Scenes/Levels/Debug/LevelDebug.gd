extends Node2D

class_name Level

const CLASS : String = "Level"

onready var screen_size : Vector2 = get_viewport().get_size()
onready var player : Node = $Player

var players_array : Array

func _ready():
	GAME.set_current_level(self)

func _process(_delta):
	if(player.position.y > 540):
		player.destroy()

func is_class(value: String) -> bool:
	return value == CLASS

func get_class() -> String:
	return CLASS
