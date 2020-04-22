extends KinematicBody2D

class_name Player

# Store all the children references
onready var attributes_node = get_node("Attributes")
onready var physic_node = get_node("Physic")
onready var direction_node = get_node("Direction")
onready var inputs_node = get_node("Inputs")

var level_node : Node

# Get every children of this node
onready var children_array : Array = get_children()

var tar_args : Array

# Class accesors
func is_class(value: String):
	return value == "Player"

func get_class() -> String:
	return "Player"

# This function has to be called to setup the player, by the Game Node (Parent)
# Give every reference they need to children nodes, and then call heir setup method if it possesses it
func _ready():
	for child in children_array:
		if "character_node" in child:
			child.character_node = self
		
		if "attributes_node" in child:
			child.attributes_node = attributes_node
		
		if "physic_node" in child:
			child.physic_node = physic_node
		
		if "direction_node" in child:
			child.direction_node = direction_node
		
		if "inputs_node" in child:
			child.inputs_node = inputs_node
		
		if child.has_method("setup"):
			child.setup()

func _physics_process(_delta):
#	print(attributes_node.speed)
	pass
func destroy():
	GAME.gameover()
	queue_free()

func say_something():
	print("Hi guys, How are you tOdAy ?????")

# This function will set the player's speed by a command
func cmd_setspeed():
	if(tar_args.size() > 0): # Check if at least 1 argument is in the array
		var new_speed : int = tar_args[1].to_int() # variable to store the speed argument
		if(new_speed > 0 and new_speed < attributes_node.MAX_SPEED):
			attributes_node.set_speed(new_speed) # Change player's speed if the Given New Speed is between the right range
		tar_args.clear() # Clear the array for new incoming inputs
