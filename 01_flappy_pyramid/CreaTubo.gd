extends Node

@export var Bloque: PackedScene
var i = 0
var existe_hueco = false
var no_instanciar = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for n in 20:
		if existe_hueco == false && n != 0 && n != 19:
			if randi() % 2:
				no_instanciar = true
				existe_hueco = true
		
		if no_instanciar == true:
			i += 1
			if i >= 4:
				no_instanciar = false
		else:
			var e = Bloque.instantiate()
			add_child(e)
			e.position = Vector2 (0,(n*32)+16)
			print("Instanciado bloque ", n)
		
