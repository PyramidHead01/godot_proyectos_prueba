extends Node

#Esto es digamos la forma de cargar un prefab en unity
@export var Enemigo: PackedScene
var score

func _ready():
	$AudioFondo.stream = load("res://Temazo Tetris.wav")
	$AudioFondo.play()

func inicio():
	score = 0
	#Asi podemos ejecutar una funcion
	#procedente de otro nodo
	#
	#Lo que esta dentro del parentesis
	#es para que se coloque en el
	#centro, segun el Marker2D
	$Player.inicio($PlayerPos.position)
	#Se inicia el contador
	$InicioTimer.start()
	
	$Interfaz.mostrar_mensaje("Listo!")
	$Interfaz.update_score(score)
	
	$AudioFondo.stream = load("res://La unica cancion buena de Darks Souls.wav")
	$AudioFondo.play()

#Esto viene de una senal mandada por Player (hit)
func game_over():
	$AudioFondo.stop()
	$PuntuacionTimer.stop()
	$EnemigoTimer.stop()
	$Interfaz.game_over()
	$AudioHit.play()
	$AudioFondo.stream = load("res://Temazo Tetris.wav")
	$AudioFondo.play()

#Cuando el contador acabe, el juego
#empezara, y por eso hace los objetos
func _on_inicio_timer_timeout():
	$EnemigoTimer.start()
	$PuntuacionTimer.start()

#Cuando el contador acabe, anadira 
#un punto exta
func _on_puntuacion_timer_timeout():
	score += 1
	$Interfaz.update_score(score)

func _on_enemigo_timer_timeout():
	#Esto quiere decir, el Path Follow
	#recorre toda la ventana,
	#y elegira un valor aleatorio
	#para generar los enemigos
	$SpawnEnemigo/EnemigoPos.set_progress(randi())
	#Instanciamos enemigo
	#RECUERDA, necesitas
	#el packed scene
	var e = Enemigo.instantiate()
	
	#Lo volvemos hijo
	add_child(e)
	
	#Le decimos la posicion segun el Path
	e.position = $SpawnEnemigo/EnemigoPos.position
	
	#Le damos una rotacion al objeto
	#
	#La segunda linea es para que tenga 
	#cierta aleatoriedad
	var d = $SpawnEnemigo/EnemigoPos.rotation
	d += randi_range(-PI/4,PI/4)
	
	e.rotation = d

	e.set_linear_velocity(Vector2(0,e.vel).rotated(d))
