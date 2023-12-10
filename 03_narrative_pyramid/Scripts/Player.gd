extends Area2D

@export var vel = 0

var mov = Vector2()
var lim

#Comprueba si puede interactuar con algun elemento, sea puerta, ventana, etc
var interaccion = false

#Cuando interactuamos con un elemento, y este tiene un dialogo, guardamos aqui el valor del dialogo
var ruta_csv

#Cogemos la ruta nodo de interfaz Dialogo
var ui_dialogo


func _ready():
	#Obtenemos un array con la resolucion total de la ventana
	lim = get_viewport_rect().size

	#Seteamos interfaz dialogo
	ui_dialogo = get_owner().get_node("InterfazDialogo")

func _process(delta):
	
	#Reseteamos el vector para que pueda quedarse quieto
	mov = Vector2()
	
	#Dependiendo de que boton pulsemos, ie dira al vector que tiene que ir a un sitio u otro
	if !ui_dialogo.dialogo_activo:
		if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D):
			mov.x += 1
		if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
			mov.x -= 1
	
	#Darle el movimiento en si al objeto
	if mov.length() > 0:
		mov = mov.normalized() * vel
	
	#Como el Time.deltaTime en unity, para que funcione igual en distintos ordenadores
	position += mov*delta

	#Si estamos dentor de una colision, entonces podremos si pulsamos espacio empezar el dialogo
	if interaccion && Input.is_action_just_pressed("ui_select") && !ui_dialogo.dialogo_activo:
		ui_dialogo.dialogo_activo = true
		ui_dialogo.pre_dialogo(ruta_csv,get_owner().idioma)

#Un collision enter, lo mas destacable es que al entrar, hacemos que coja la ruta del CSV
#tambien decir que unicamente interactua con aquellos grupos que sean "Dialogo"
func _on_body_entered(body):
	if body.is_in_group("Dialogo"):
		$IconoInteraccion.show()
		interaccion = true
		ruta_csv = body.ruta_csv
func _on_body_exited(body):
	if body.is_in_group("Dialogo"):
		$IconoInteraccion.hide()
		interaccion = false
