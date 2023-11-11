extends CharacterBody2D

@export var vel = 100
@export var salto = -400.0
@export var gravity = 1000
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal hit

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_select"):
		velocity.y = salto

	#Con esto movemos lateralmente el objeto
	#velocity.x = vel

	move_and_slide()

func _on_area_2d_area_entered(area):
	emit_signal("hit")

func game_over():
	print("MUELTE")
