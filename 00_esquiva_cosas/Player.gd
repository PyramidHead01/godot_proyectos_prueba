extends Area2D


@export var vel = 0
var mov = Vector2()
var lim

# ES UN VOID START LA COSA ESTA
#func _ready():
#	pass

# ES UN VOID UPDATE LA COSA ESTA
#func _process(delta):
#	pass

func _ready():
	#Obtenemos un array con la resolucion total de la ventana
	lim = get_viewport_rect().size
	pass
	
func _process(delta):
	
	#Reseteamos el vector para que pueda quedarse quieto
	mov = Vector2()
	
	#Dependiendo de que boton pulsemos, ie dira al vector que tiene que ir a un sitio u otro
	if Input.is_action_pressed("ui_right"):
		mov.x += 1
	if Input.is_action_pressed("ui_left"):
		mov.x -= 1
	if Input.is_action_pressed("ui_up"):
		mov.y -= 1
	if Input.is_action_pressed("ui_down"):
		mov.y += 1
	
	#Darle el movimiento en si al objeto
	if mov.length() > 0:
		mov = mov.normalized() * vel
	
	#Como el Time.deltaTime en unity, para que funcione igual en distintos ordenadores
	position += mov*delta
	
	#Limites para que el player no salga de ahi
	position.x = clamp(position.x,100,lim.x-100)
	position.y = clamp(position.y,100,lim.y-100)
	
	#Dependiendo del vector, cargara una animacion u otra
	if mov.y != 0:
		if mov.y < 0:
			$AnimatedSprite2D.animation = "arriba"
		else: 
			$AnimatedSprite2D.animation = "abajo"
	elif mov.x != 0:
		$AnimatedSprite2D.animation = "lateral"
		$AnimatedSprite2D.flip_h = mov.x > 0
	else:
		$AnimatedSprite2D.play("idle")

	pass
	
	
