extends Node2D

class_name Level

const CLASS : String = "Level"

onready var screen_size : Vector2 = get_viewport().get_size()
onready var player : Node = $Player
onready var checkpoints_array : Array
onready var console_node : Node = get_node("GameConsole")

var players_array : Array

func _ready():
	GAME.set_current_level(self)
	if(find_node("Checkpoints")):
		var cp_nodes : Node = find_node("Checkpoints")
		checkpoints_array = cp_nodes.get_children()
		for cp in checkpoints_array:
			if "player_node" in cp:
				cp.player_node = player
			if "console" in cp:
				cp.console = console_node
			if !cp.cp_enabled:
				cp.visible = false
	if(player):
		if "console" in player:
			player.console = console_node
	
	console_node.open_console()

func _process(_delta):
	if(player.position.y > 540):
		player.destroy()

func is_class(value: String) -> bool:
	return value == CLASS

func get_class() -> String:
	return CLASS
