extends Node

onready var game_over_scene = preload("res://Scenes/Menus/GameOverScene/GameOver.tscn")
onready var pause_menu_scene = preload("res://Scenes/Menus/PauseMenu/PauseMenu.tscn")
onready var option_menu_scene = preload("res://Scenes/Menus/OptionsMenu/OptionsMenu.tscn")
onready var title_screen_scene = preload("res://Scenes/Menus/ScreenTitle/ScreenTitle.tscn")

# Triggers the game over scene
func gameover():
	var _err = get_tree().change_scene_to(game_over_scene)
