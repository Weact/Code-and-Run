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

func destroy():
	GAME.gameover()
	queue_free()
