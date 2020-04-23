extends Control

class_name GameConsoleScript

onready var console_input_node = get_node("Console Input/CMDInput")
onready var console_cmdlog_node = get_node("LOG/CMDLogs_container")
onready var cmdsendingsound_node = get_node("CMDSendingSound")
onready var console_quit_node = get_node("Console Quit/ConsoleQUIT")

onready var children_cmd = get_node("CommandsList").get_children()

const CONSOLE_CMDLOGS_FONTSIZE : int = 45

var cheats_enabled : bool = false
var console_cmdlog_itemcount = 1

var COMMANDS = {
	"HELP": { #0
		"type": TYPE_STRING,
		"cmd_name": "help",
		"description": "Display All Commands",
		"args": {"min": 0, "max": 1},
		"cheats_required": false
	},
	"CHEATS": { #1
		"type": TYPE_STRING,
		"cmd_name": "cheats",
		"description": "Turn Cheats On/Off",
		"args": [],
		"cheats_required": false
	},
	"CLEAR": { #2
		"type": TYPE_STRING,
		"cmd_name": "clear",
		"description": "Clear The Console",
		"args": [],
		"cheats_required": false
	},
	"NOCLIP": { #3
		"type": TYPE_STRING,
		"cmd_name": "noclip",
		"description": "Give Noclip To All Players",
		"args": [],
		"cheats_required": true
	},
	"GRAVITY": { #8
		"type": TYPE_STRING,
		"cmd_name": "gravity",
		"description": "Change The Gravity.",
		"args": ["value"],
		"cheats_required": true
	},
	"INFINITEJUMP": { #9
		"type": TYPE_STRING,
		"cmd_name": "infinitejump",
		"description": "Allow The Players To Jumps Indefinitely",
		"args": [],
		"cheats_required": true
	},
	"GODMOD": { #10
		"type": TYPE_STRING,
		"cmd_name": "godmod",
		"description": "Make All Players Invincible",
		"args": [],
		"cheats_required": true
	},
	"NEXTLEVEL": { #11
		"type": TYPE_STRING,
		"cmd_name": "nextlevel",
		"description": "Go To The Next Level",
		"args": [],
		"cheats_required": true
	},
	"PREVIOUSLEVEL": { #12
		"type": TYPE_STRING,
		"cmd_name": "previouslevel",
		"description": "Go To The Previous Level",
		"args": [],
		"cheats_required": true
	},
	"GOTOLEVEL": { #13
		"type": TYPE_STRING,
		"cmd_name": "gotolevel",
		"description": "Go To A Specific Levell",
		"args": ["id_level"],
		"cheats_required": true
	},
	"DIE": { #14
		"type": TYPE_STRING,
		"cmd_name": "die",
		"description": "Suicide",
		"args": [],
		"cheats_required": false
	},
	"GAMESPEED": { #20
		"type": TYPE_STRING,
		"cmd_name": "gamespeed",
		"description": "Change The Game Speed. (include gaz speed, players speed and more)",
		"args": ["value"],
		"cheats_required": true
	},
	"WJAOIDQK7A9": { #24
		"type": TYPE_STRING,
		"cmd_name": "wjaoidqk7a9",
		"description": "Secret",
		"args": [],
		"cheats_required": true
	}
}

# This function ready will initialize signals and init the console logs
## init_console_cmdlog : init font size of console's log
func _ready():
	self.set_visible(false)
	var _err
	_err = console_input_node.connect("text_entered", self, "_on_cmd_submitted")
	_err = console_quit_node.connect("pressed", self, "_on_consolequit_button_toggled")
	_err = console_input_node.connect("text_changed", self, "_on_cmd_changed")
	
	for child in children_cmd:
		if "console_cmdlog_node" in child:
			child.console_cmdlog_node = console_cmdlog_node
		if "console" in child:
			child.console = self
		if "all_cmd" in child:
			child.all_cmd = children_cmd
	
	init_console_cmdlog()

func _physics_process(_delta):
	pass

# Check when a player press "display_console" input (Default: F2).
## Display the console and pause the game
func _input(_e):
	if Input.is_action_just_pressed("display_console"):
			get_tree().paused = !get_tree().paused
			self.set_visible(!self.visible)

# Detect when the player type in the console
## Change the color of his input if it corresponds to any commands listed in the dictionnary
func _on_cmd_changed(_text):
	var cmd_split : Array = _text.to_upper().split(" ")
	if(find_node(cmd_split[0])):
		console_input_node.add_color_override("font_color", Color(1,0,1,1))
	else:
		console_input_node.add_color_override("font_color", Color(1,1,1,1))

# When the player submit a command
## Check if it's valid
### Action it
#### !!! REFACTORY NEEDED !!!
func _on_cmd_submitted(cmd : String):
	if cmd:
		cmdsendingsound_node.play() #Play a sound when a player enter a command
		
		var cmd_split : Array = cmd.to_upper().split(" ") # Separate every words in the commands by a space
		var node_cmd : Node = find_node(cmd_split[0])
		# Take the first index's value (commands)
		# and try to find the corresponding node
		
		if(node_cmd): # If the node exist
			node_cmd.cmd_args.clear()
			if(node_cmd.args_number > 0): # If there is at least 1 required arguments for the cmd
				if(cmd_split.size() > 1): 	# If the user cmd was followed by at least 1 argument
											# (means his input is MAYBE correct)
					for i in range (cmd_split.size()): # We go through the splitted array
						node_cmd.cmd_args.append(cmd_split[i].to_int()) # We add every argument to the array of the command
																		# (Even the cmd_name, but it will be handled and ignored later)

			node_cmd.exec_cmd() #We execute the command

		console_input_node.clear() #clear the input field

func _on_consolequit_button_toggled():
	get_tree().paused = !get_tree().paused
	self.set_visible(!self.visible)
	
func init_console_cmdlog():
	console_cmdlog_node.get_font("font").set_size(CONSOLE_CMDLOGS_FONTSIZE)
