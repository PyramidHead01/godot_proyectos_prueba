extends Node

@export var Tubo: PackedScene
signal finTubo
var score = 0
	
func _on_timer_tubo_timeout():
	#Puntuacion
	score = score + 1
	#Tubo
	var e = Tubo.instantiate()
	add_child(e)
	#Esto ultimo es para decirle que, 
	#el tubo que acabamos de crear va
	#a tener una variable asignada
	#al signal finTubo, y asi 
	#afectara a todos los nodos
	#Si miras el codigo, veras que ahi hay
	finTubo.connect(e._signal_fin_tubo)
	
func _signal_hit():
	#Mandamos senal fin del juego al player
	$Player.game_over()
	
	#Decimos al Crea Tubo que va a dejar de 
	#acelerar objetos con el Stop, y con el Emit
	#hacemos que se paren de mover todos
	#los tubos
	$TimerTubo.stop()
	emit_signal("finTubo")

func _on_ui_inicio():
	#Interfaz
	$UI/Score.show()
	$UI/Titulo.hide()
	$UI/Button.hide()
	#Juego
	$Player.show()
	$TimerTubo.start()

func _process(delta):
	$UI/Score.text = str(score)
