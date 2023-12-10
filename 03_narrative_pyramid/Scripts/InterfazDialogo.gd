extends CanvasLayer

var linea
var arrayDialogo = []
var dialogo_activo
var i = -1

#Tapamos el interfaz de dialogo
func _ready():
	hide()

func _process(_delta):
	#Si puede hablar, al pulsar espacio carga la siguiente linea
	if dialogo_activo && Input.is_action_just_pressed("ui_select"):
		_siguienteLinea()

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
	hide()


#Procesos extra aparte de los metodos de dialogo

#Cogemos los datos del CSV, correpondiendo a la ruta y al idioma asignado
func _leerCSV(ruta,idioma):

	var file = FileAccess.open(ruta, FileAccess.READ)
	
	while !file.eof_reached():
		linea=file.get_csv_line("\t")
		arrayDialogo.append(linea[idioma])
	print(arrayDialogo)
	print(arrayDialogo.size())
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
