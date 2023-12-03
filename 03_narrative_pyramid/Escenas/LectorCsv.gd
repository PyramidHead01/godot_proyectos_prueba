extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	leerCSV("res://CSV/dialgos.csv",2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func leerCSV(ruta,idioma):
	var file = FileAccess.open(ruta, FileAccess.READ)
	var linea
	while !file.eof_reached():
		linea=file.get_csv_line("\t")
		prints(linea[idioma])
