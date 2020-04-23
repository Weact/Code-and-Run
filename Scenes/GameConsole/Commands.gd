extends Node

class_name Commands

var console_cmdlog_node : Node

export var cmd_name : String = "" #command name
export var args_number : int #number of required argument
export var cmd_args : Array = [] #array of all argument gave by the player (=> Filled from GameConsole.gd)
export var cmd_description : String = "" #command description
export var cheats_required : bool = false #cheats will have to be ON to execute the command

export var target : String = "" #node target
export var target_as_group : bool = false #is the target a group of target ?
export var target_method : String = "" #target method

# This function will execute the command by :
## Putting every nodes "target" in a group "group_target"
### For every NODE in the GROUP,
#### Check if the Array TAR_ARGS exist => TAR_ARGS is the array that will contain all required arguments
##### Fill the node's TAR_ARGS array with the given argument(s)
###### CALL THE TARGET METHOD
func exec_cmd():
	if target == "" or target_method == "":
		console_cmdlog_node.add_item(" > Can't find the target or target method.")
		return
	
	var target_array : Array = []
	if target_as_group:
		target_array = get_tree().get_nodes_in_group(target)
	else:
		target_array.append(get_tree().get_current_scene().find_node(target))
	
	for target_name in target_array:
		if target_name.has_method(target_method):
			var call_def_funcref := funcref(target_name, "call_deferred")
			cmd_args.push_front(target_method)
			cmd_args.remove(1)
			call_def_funcref.call_funcv(cmd_args)
			
#func exec_cmd():
#	var group_target : Array = get_tree().get_nodes_in_group(target)
#	for target in group_target:
#			if "tar_args" in target:
#				target.tar_args = cmd_args
#			target.call_deferred(target_method)
