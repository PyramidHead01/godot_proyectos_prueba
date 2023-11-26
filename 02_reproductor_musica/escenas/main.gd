extends CanvasLayer

var ruta = "res://sonido/musica/"
var indexCancion = 0
var canciones = []
var pausado = false
var temp = 0
var nombre
var duracion = 0
#Para cambiar el icono de los botones deben estar precargados
var iconPause = preload("res://sprites/iconos/iconoPausa.png")
var iconPlay = preload("res://sprites/iconos/iconoPlay.png")

func _ready():
	ObtenerValores()
	CargarCancion(indexCancion)
	
func _process(delta):
		#Con esto damos el valor actual al slider

		temp = $Audio/Musica.get_playback_position()
		$Tiempo/BarraTiempo.value = temp
		$Tiempo/TiempoIzqu.text = str(temp).pad_decimals(2)
	
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
		$Audio/Musica.play(temp)
		$Botones/BotPausePlay.icon = iconPause
		pausado = false
	else:
		print("Pausado la musica en: " + str(temp))
		$Audio/Musica.stop()
		$Botones/BotPausePlay.icon = iconPlay
		pausado = true

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

func _on_barra_tiempo_value_changed(value):
	temp = value
	$Tiempo/BarraTiempo.value = temp
	$Audio/Musica.play(temp)
