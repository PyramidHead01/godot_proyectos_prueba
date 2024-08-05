extends CharacterBody2D

var vel = 500

func _ready():
	pass

func _physics_process(delta):
	
	velocity = Vector2(0,0)
	
	if Input.is_action_pressed("move_right"):
		velocity.x = vel
	if Input.is_action_pressed("move_left"):
		velocity.x = -vel
	if Input.is_action_pressed("move_up"):
		velocity.y = -vel
	if Input.is_action_pressed("move_down"):
		velocity.y = vel
		
	move_and_slide()

	var screen_size = get_viewport_rect().size

	#global_position.x = clamp(global_position.x,0,screen_size.x)
	#global_position.y = clamp(global_position.y,0,screen_size.y)

	
	global_position = global_position.clamp(Vector2(0,0),screen_size)
