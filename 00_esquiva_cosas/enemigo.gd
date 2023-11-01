extends RigidBody2D

@export var vel_min = 0
@export var vel_max = 0
var vel = vel_min
var tipo_enemigo = ["azul","rojo"]

var mov = Vector2() 

func _ready():
	#Elegira un valor aleatorio de los dos del array tipo_enemigo
	$AnimEnemigo.animation = tipo_enemigo[randi() % tipo_enemigo.size()]

	if $AnimEnemigo.animation == "rojo":
		vel = vel_max
	else:
		vel = vel_min

"""
func _process(delta):
	mov.y += 100
	mov = mov.normalized() * vel
	position += mov*delta
"""

#Con esto cuando salga de la ventana el objeto desaparecera
func _on_visible_screen_exited():
	queue_free()
