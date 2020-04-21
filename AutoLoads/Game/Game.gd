extends Node2D

onready var gameover_timer_node = $GameoverTimer

const level1 = preload("res://Scenes/Levels/Debug/DebugLevel.tscn")
const debug_level = preload("res://Scenes/Levels/Debug/DebugLevel.tscn")

var player = preload("res://Scenes/Player/Player.tscn")

var current_level = level1 setget set_current_level, get_current_level

func _ready():
	var _err = gameover_timer_node.connect("timeout",self, "on_gameover_timer_timeout")

func set_current_level(level : Node):
	current_level = load(level.get_filename())

func get_current_level():
	return current_level

func goto_level(level = current_level):
	var _err = get_tree().change_scene_to(level)

# Triggers the timer before the gameover is triggered
# Called when a player die
func gameover():
	gameover_timer_node.start()
	get_tree().get_current_scene().set_process(false)

#  Change scene to go to the gameover scene after the timer has finished
func on_gameover_timer_timeout():
	gameover_timer_node.stop()
	var _err = get_tree().change_scene_to(MENUS.game_over_scene)
