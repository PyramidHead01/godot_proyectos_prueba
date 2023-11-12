extends CanvasLayer

signal inicio

func _on_button_pressed():
	emit_signal("inicio")
	print("Vuelve a jugar")
