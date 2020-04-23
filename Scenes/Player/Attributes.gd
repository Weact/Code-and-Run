extends Node

const MIN_SPEED = 1
const MAX_SPEED = 999
const MIN_GRAVITY = 1
const MAX_GRAVITY = 999

export (int, 1, 999) var speed setget set_speed, get_speed
export var jump_force : int setget set_jump_force, get_jump_force
export (int, 1, 999) var gravity setget set_gravity, get_gravity

var velocity : Vector2 setget set_velocity, get_velocity

func set_speed(value : int):
	value = clamp(value, MIN_SPEED, MAX_SPEED) as int
	speed = value

func get_speed() -> int:
	return speed

func set_gravity(value : int):
	gravity = value

func get_gravity() -> int:
	return gravity

func set_velocity(value : Vector2):
	velocity = value

func get_velocity() -> Vector2:
	return velocity

func set_jump_force(value : int):
	jump_force = value

func get_jump_force() -> int:
	return jump_force
