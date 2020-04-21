extends Control

class_name GameConsoleScript

onready var console_input_node = get_node("Console Input/CMDInput")
onready var console_cmdlog_node = get_node("LOG/CMDLogs_container")
onready var cmdsendingsound_node = get_node("CMDSendingSound")
onready var console_quit_node = get_node("Console Quit/ConsoleQUIT")

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


func _ready():
	self.set_visible(false)
	var _err
	_err = console_input_node.connect("text_entered", self, "_on_cmd_submitted")
	_err = console_quit_node.connect("pressed", self, "_on_consolequit_button_toggled")
	_err = console_input_node.connect("text_changed", self, "_on_cmd_changed")
	
	init_console_cmdlog()

func _physics_process(_delta):
	pass

func _input(_e):
	if Input.is_action_just_pressed("display_console"):
			get_tree().paused = !get_tree().paused
			self.set_visible(!self.visible)

func _on_cmd_changed(_text):
	for i in range (COMMANDS.size()):
		if _text != COMMANDS.values()[i].cmd_name:
			console_input_node.add_color_override("font_color", Color(1,1,1,1))
		elif _text == COMMANDS.values()[i].cmd_name:
			console_input_node.add_color_override("font_color", Color(1,0,1,1))
			break

func _on_cmd_submitted(cmd : String):
	if cmd:
		cmdsendingsound_node.play() #Play a sound when a player enter a command
		
		for i in range (COMMANDS.size()):
			if(cmd.to_upper() == COMMANDS.keys()[i]):
				if(cheats_enabled == false):
					if(COMMANDS.values()[i].cheats_required == true):
						console_cmdlog_node.add_item("#" + console_cmdlog_itemcount as String + " > "+ cmd +" : COMMAND NOT AVAILABLE: CHEATS ARE DISABLED < ".to_lower()) #add the item
						console_cmdlog_itemcount += 1
						break
					else:
						#START
						if(cmd.to_upper() == COMMANDS.keys()[0]): # 0 : Help
							console_cmdlog_node.clear()
							for j in range (COMMANDS.size()):
								console_cmdlog_node.add_item(COMMANDS.values()[j].cmd_name + " > " + COMMANDS.values()[j].description .to_lower())
						elif(cmd.to_upper() == COMMANDS.keys()[1]): # 1 : CHEATS
							if(!cheats_enabled):
								cheats_enabled = !cheats_enabled
								console_cmdlog_node.add_item(" > " + cmd + " : CHEATS ARE NOW ON".to_lower())
							else:
								cheats_enabled = !cheats_enabled
								console_cmdlog_node.add_item(" > " + cmd + " : CHEATS ARE NOW OFF".to_lower())
						elif(cmd.to_upper() == COMMANDS.keys()[2]): # 2 : CLEAR
							console_cmdlog_node.clear()
						#END
						console_cmdlog_itemcount += 1
						break
				else:
					#START
					if(cmd.to_upper() == COMMANDS.keys()[0]): # 0 : Help
						console_cmdlog_node.clear()
						for j in range (COMMANDS.size()):
							console_cmdlog_node.add_item(COMMANDS.values()[j].cmd_name + " > " + COMMANDS.values()[j].description .to_lower())
					elif(cmd.to_upper() == COMMANDS.keys()[1]): # 1 : CHEATS
						if(!cheats_enabled):
							cheats_enabled = !cheats_enabled
							console_cmdlog_node.add_item(" > " + cmd + " : CHEATS ARE NOW ON".to_lower())
						else:
							cheats_enabled = !cheats_enabled
							console_cmdlog_node.add_item(" > " + cmd + " : CHEATS ARE NOW OFF".to_lower())
					elif(cmd.to_upper() == COMMANDS.keys()[2]): # 2 : CLEAR
						console_cmdlog_node.clear()
					#END
					console_cmdlog_itemcount += 1
					break
				console_cmdlog_itemcount += 1
				break

		console_input_node.clear() #clear the input field

func _on_consolequit_button_toggled():
	get_tree().paused = !get_tree().paused
	self.set_visible(!self.visible)
	
func init_console_cmdlog():
	console_cmdlog_node.get_font("font").set_size(CONSOLE_CMDLOGS_FONTSIZE)
