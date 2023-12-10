extends CanvasLayer

var ruta = "res://sonido/musica/"
var indexCancion = 0
var canciones = []
var pausado = false
var temp = 0
var nombre
var duracion = 0
var loop = false
var sliderTiempo = false
#Para cambiar el icono de los botones deben estar precargados
var iconPause = preload("res://sprites/iconos/iconoPausa.png")
var iconPlay = preload("res://sprites/iconos/iconoPlay.png")

var sonMusica = AudioServer.get_bus_index("Musica")

func _ready():
	ObtenerValores()
	CargarCancion(indexCancion)

func _process(delta):
	#print(temp)
	#Con esto damos el valor actual al slider
	if !pausado:
		temp = $Audio/Musica.get_playback_position()
		$Tiempo/TiempoIzqu.text = str(temp).pad_decimals(2)
		$Tiempo/BarraTiempo.value = temp

func ObtenerValores():
	#Seteo las variables basicas que utilizo
	var dir = DirAccess.open(ruta)
	var i = 1 
	var texto = ""
	
	print(dir)
	
	if dir:
		#Preparamos la carpeta
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		#Cuando no encuentre ningun archivo, 
		#este parara el bucle
		while file_name != "":

			#Godot genera un archivo .import, 
			#juraria que es al compilar.
			#Como no nos interesa, lo ignoramos
			if file_name.get_extension() != "import":
				i += 1
				
				texto = str(texto,file_name)
				texto += "\n"
				
				canciones.append(ruta+file_name)
			
			#Cogemos el siguiente archivo
			file_name = dir.get_next()
			
		$TodosTitulos.text = texto
		
		print(canciones)
		
	else:
		print("An error occurred when trying to access the path.")

func CargarCancion(i = 0):
	
	#Anadir cancion en si
	$Audio/Musica.stream = load(canciones[i])
	$Audio/Musica.play()
	
	#Escribir texto
	nombre = canciones[i].replacen(ruta,"")
	nombre = nombre.replacen(".mp3","")
	print(nombre)
	$TituloActual.text = (str(i) + "." + nombre)

	#Slider Tiempo
	duracion = $Audio/Musica.stream.get_length()
	print(duracion)
	$Tiempo/BarraTiempo.max_value = duracion
	$Tiempo/TiempoDer.text = str(duracion).pad_decimals(2)

#Pulsado Boton Pausa Play
func _on_bot_pause_play_pressed():
	if pausado:
		pausado = false
		print("Reiniciara en: " + str(temp))
		$Audio/Musica.play(temp)
		$Botones/BotPausePlay.icon = iconPause
	else:
		pausado = true
		print("Pausado la musica en: " + str(temp))
		temp = $Audio/Musica.get_playback_position()
		$Audio/Musica.stop()
		$Botones/BotPausePlay.icon = iconPlay

#Pulsado Boton Siguiente Cancion
func _on_bot_son_sig_pressed():
	
	indexCancion += 1
	
	if(indexCancion > canciones.size()-1):
		indexCancion = 0
	
	CargarCancion(indexCancion)

#Pulsado Boton Anterior Cancion
func _on_bot_son_anterior_pressed():
	
	indexCancion -= 1
	
	if(indexCancion < 0):
		indexCancion = canciones.size()-1
	
	CargarCancion(indexCancion)

#Slider tiempo
func _on_barra_tiempo_value_changed(value):
	temp = value
	if !sliderTiempo:
		pass
	
	if sliderTiempo:
		$Audio/Musica.play(temp)
		$Tiempo/BarraTiempo.value = temp

#Slider volumen
func _on_slider_volumen_value_changed(value):
	#$Audio/Musica.volume_db = value
	$Volumen/ValorVolumen.text = "[" + str(value) + "]"
	AudioServer.set_bus_volume_db(sonMusica,linear_to_db(value))

#Slider velocidad
func _on_slider_vel_value_changed(value):
	$Audio/Musica.pitch_scale = value
	$Velocidad/VelCentro.text = "[" + str(value) + "]"

#Toggle Loop
func _on_toggle_loop_toggled(button_pressed):
	if button_pressed:
		loop = true
	else:
		loop = false
		
	print("La variable bucle esta en: " + str(loop))

#Loop
func _on_musica_finished():
	#print("ACABADO")
	#$Audio/Musica.stop()
	pass
	#if loop:
	#	$Audio/Musica.play()
	#else:
	#	$Audio/Musica.stop()




func _on_barra_tiempo_drag_started():
	print("Entras en el slider")
	sliderTiempo = true

func _on_barra_tiempo_drag_ended(value_changed):
	print("Sales del slider")
	sliderTiempo = false
