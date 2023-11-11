extends Area2D

@export var vel = 0
var mov = Vector2()
var lim

signal hit

# ES UN VOID START LA COSA ESTA
#func _ready():
#	pass

# ES UN VOID UPDATE LA COSA ESTA
#func _process(delta):
#	pass

func _ready():
	#Con esto el player en el frame 1 se ocultara y no se vera
	hide()
	#Obtenemos un array con la resolucion total de la ventana
	lim = get_viewport_rect().size
	
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
			$AnimPlayer.animation = "arriba"
		else: 
			$AnimPlayer.animation = "abajo"
	elif mov.x != 0:
		$AnimPlayer.animation = "lateral"
		$AnimPlayer.flip_h = mov.x > 0
	else:
		$AnimPlayer.play("idle")

#Es una funcion integrada, seria como un on collision enter
func _on_body_entered(body):
	print("AAAAA")
	hide()
	emit_signal("hit")
	#Ocultamos la colision
	$ColPlayer.set_deferred("disabled", true)

func inicio(pos):
	position = pos
	#Para hacer que aparezca el objeto
	show()
	#Ahora si o si en el inicio la colision estara activa
	$ColPlayer.disabled = false
