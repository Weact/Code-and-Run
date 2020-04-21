extends Node

var inputs_node : Node
var character_node : Node

var dirLeft : int = 0 
var dirRight : int = 0

func _input(event):
	if event.is_action_pressed(inputs_node.input_map["MoveLeft"]):
		dirLeft = 1
		dirRight = 0
		
	#elif event.is_action_released(inputs_node.input_map["MoveLeft"]):
	#	dirLeft = 0
	
	elif event.is_action_pressed(inputs_node.input_map["MoveRight"]):
		dirRight = 1
		dirLeft = 0
	
	#elif event.is_action_released(inputs_node.input_map["MoveRight"]):
	#	dirRight = 0


# Returns the direction of the robot
func get_move_direction() -> int:
	return dirRight - dirLeft
