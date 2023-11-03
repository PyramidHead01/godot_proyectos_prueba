extends RigidBody2D

@export var intensisdad = 0
var vec = Vector2(0,1)

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		print("A")
