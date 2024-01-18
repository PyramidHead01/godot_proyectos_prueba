extends CanvasLayer

var linea
var arrayDialogo = []

#Booleanas que comprueban varios estados de los booleanos
var dialogo_activo = false
var dialogo_auto = false

#Cabezal
var i = -1
var id_idoma = -1


#Tapamos el interfaz de dialogo
func _ready():
	hide()

func _process(_delta):
	#Si puede hablar 
	if dialogo_activo:
		#Pulsar espacio carga la siguiente linea
		if Input.is_action_just_pressed("ui_select"):
			_siguienteLinea()

		#Pulsar aceptar para activar modo auto
		if Input.is_action_just_pressed("ui_focus_next"):
			if $Timer_Modo_Auto.get_time_left() == 0:
				$Timer_Modo_Auto.start()
			else:
				$Timer_Modo_Auto.stop()

#Estados del UI dialogo

#Estado de precarga donde prepara todos los elementos que se usaran
func pre_dialogo(ruta,idioma):

	_leerCSV(ruta,idioma)

	show()

	$Texto.text = ""
	$Nombre_Personaje.text = ""

	dialogo_activo = true
#Para cuando salga, por ahora ocupa solo una linea, pero luego sera mas complejo
func post_dialogo():
	$Timer_Modo_Auto.stop()
	hide()


#Procesos extra aparte de los metodos de dialogo

#Cogemos los datos del CSV, correpondiendo a la ruta y al idioma asignado
func _leerCSV(ruta,idioma):

	var file = FileAccess.open(ruta, FileAccess.READ)
	
	linea = file.get_csv_line("\t")

	for num in linea
		id_idioma += 1
		if num = idioma:
			break

	while !file.eof_reached():
		linea=file.get_csv_line("\t")
		if linea[0] != "":
			arrayDialogo.append(linea[id_idioma])

#Cargamos la siguiente linea de texto
func _siguienteLinea():
	i += 1
	if arrayDialogo.size() == i:
		print("Fuera de dialogo")
		dialogo_activo = false
		post_dialogo()
	else:
		print(arrayDialogo[i])
		$Texto.text = arrayDialogo[i]

func _on_timer_modo_auto_timeout():
	_siguienteLinea()
		
