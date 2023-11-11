extends RigidBody2D

@export var intensisdad = 0
var vec = Vector2(0,1)
var vivo = true;
var fin = true;

func _process(delta):
	if Input.is_action_just_pressed("ui_select") && vivo && fin:
		print("A")
