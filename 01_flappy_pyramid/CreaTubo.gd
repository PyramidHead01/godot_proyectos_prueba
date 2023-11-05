extends Area2D

@export var Bloque: PackedScene
@export var vel = 100
var i = 0
var existe_hueco = false
var no_instanciar = false
var mov = Vector2(100,0)

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
			e.position = Vector2 (376,(n*32)+16)
			#velocity.x = vel
			#print("Instanciado bloque ", n)
		
func _process(delta):
	position -= mov*delta
