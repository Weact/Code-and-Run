extends Node

const GRAVITY : int = 30

var attributes_node : Node
var character_node : KinematicBody2D
var direction_node : Node
var inputs_node : Node

var jump_available : bool = true
var bounce_available : bool = true

var go_left = InputEventAction.new()
var go_right = InputEventAction.new()

var bounce_wall_timer : Timer

func _ready():
	init_simulate_inputs()
	
	bounce_wall_timer_instance()
	
#This function initialize the inputs which will be simulated to "bounce" the player against a wall
func init_simulate_inputs():
	go_left.action = "move_left"
	go_left.pressed = true
	go_right.action = "move_right"
	go_right.pressed = true

#This function init a timer which will be used to be started in order to reset bounce_available state
func bounce_wall_timer_instance():
	bounce_wall_timer = Timer.new()
	bounce_wall_timer.wait_time = 0.2
	bounce_wall_timer.one_shot = true
	bounce_wall_timer.connect("timeout",self,"_on_timer_timeout")
	add_child(bounce_wall_timer)	

func _physics_process(_delta):
	var dir = direction_node.get_move_direction()
	var spd = attributes_node.speed
	
	# Compute velocity.
	if(bounce_available and dir > 0 and character_node.is_on_wall()):
		Input.parse_input_event(go_left)
		bounce_available = false
		bounce_wall_timer.start()
	if(bounce_available and dir < 0 and character_node.is_on_wall()):
		Input.parse_input_event(go_right)
		bounce_available = false
		bounce_wall_timer.start()
		
	attributes_node.velocity.x = dir * spd
	
	# Apply movement
	attributes_node.velocity.y += GRAVITY
	attributes_node.velocity = character_node.move_and_slide(attributes_node.velocity, Vector2.UP, false, 4, PI/4, false)

	if(character_node.is_on_floor()):
		jump_available = true

func _input(event):
	if jump_available and event.is_action(inputs_node.input_map["Jump"]):
		attributes_node.velocity.y = attributes_node.jump_force
		jump_available = false
		
func _on_timer_timeout():
	bounce_available = true
