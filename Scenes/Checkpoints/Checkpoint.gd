extends Area2D

export var cp_enabled : bool = true
var console : Node

var timer_enable_cp : Timer

func _ready():
	var _err = connect("body_entered", self, "on_cp_reached")
	init_cp_timer()
	
func on_cp_reached(body):
	if(body.is_class("Player")):
		if !cp_enabled:
			timer_enable_cp.start()
		else:
			console.open_console()
			
func init_cp_timer():
	timer_enable_cp = Timer.new()
	timer_enable_cp.wait_time = 0.2
	timer_enable_cp.one_shot = true
	var _err = timer_enable_cp.connect("timeout",self,"_on_timer_timeout")
	add_child(timer_enable_cp)

func _on_timer_timeout():
	cp_enabled = true
	self.visible = true
