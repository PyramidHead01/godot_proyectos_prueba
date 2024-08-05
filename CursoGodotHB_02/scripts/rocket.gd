extends Area2D

@export var vel = 5

func _physics_process(delta):
	global_position.x += vel
