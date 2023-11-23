extends CanvasLayer

var indexCancion = 0
var canciones = []

func _ready():
	ObtenerValores()
	CargarCancion(indexCancion)
	
func ObtenerValores():
	#Seteo las variables basicas que utilizo
	var ruta = "res://sonido/musica/"
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
	$Audio/Musica.stream = load(canciones[i])
	$Audio/Musica.play()

#Pulsado Boton Pausa Play
func _on_bot_pause_play_pressed():
	if $Audio/Musica.get_strem_paused():
		pass
