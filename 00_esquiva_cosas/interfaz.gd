extends CanvasLayer

signal iniciar_juego

func mostrar_mensaje(texto):
	$Mensaje.text = texto
	$Mensaje.show()
	$MensajeTimer.start()
	
func game_over():
	mostrar_mensaje("Game Over")
	#Con esto esperara hasta que 
	#el contador haya terminado
	await $MensajeTimer.timeout
	
	$BotPlay.show()
	
	$Mensaje.text = "00_esquiva_cosas"
	$Mensaje.show()

func update_score(i):
	$Score.text = str(i)

func _on_mensaje_timer_timeout():
	$Mensaje.hide()

func _on_bot_play_pressed():
	$BotPlay.hide()
	emit_signal("iniciar_juego")
