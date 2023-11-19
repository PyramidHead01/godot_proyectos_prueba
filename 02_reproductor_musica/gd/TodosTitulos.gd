extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open("res://sonido/musica/")
	var i = 1 
	var texto = ""
	print(dir)
	
	if dir:
		dir.list_dir_begin()
		var musica = []
		var file_name = dir.get_next()
		while file_name != "":

			if file_name.get_extension() != "import":
				musica.append(file_name)
				i += 1
				texto = str(texto,file_name)
				texto += "\n"
			file_name = dir.get_next()
			
			i
			
		self.text = texto
	else:
		print("An error occurred when trying to access the path.")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
