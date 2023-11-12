extends Node

@export var Tubo: PackedScene
signal finTubo
signal reiniciarTubo
var score = -1
	
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
	reiniciarTubo.connect(e._signal_reiniciar_tubo)
	
func _signal_hit():
	#Quitamos la colision del player momentaneamiente
	$Player/Area2D/CollisionShape2D.set_deferred("disabled", true)
	
	#Decimos al Crea Tubo que va a dejar de 
	#acelerar objetos con el Stop, y con el Emit
	#hacemos que se paren de mover todos
	#los tubos
	$TimerTubo.stop()
	emit_signal("finTubo")
	$UI/Button.show()
	$UI/Titulo.text = "Game Over"
	$UI/Titulo.show()

func _on_ui_inicio():
	
	#Interfaz
	$UI/Score.show()
	$UI/Titulo.hide()
	$UI/Button.hide()
	score = -1
	
	#Tubo
	$TimerTubo.start()
	emit_signal("reiniciarTubo")

	#Player
	$Player.show()
	$Player/Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(delta):
	if score < 1:
		$UI/Score.text = str(0)
	else:
		$UI/Score.text = str(score)
