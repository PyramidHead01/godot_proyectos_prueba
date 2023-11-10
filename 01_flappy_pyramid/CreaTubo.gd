extends Area2D

@export var Bloque: PackedScene
@export var vel = 100
var i = 0
var no_instanciar = false
var mov = Vector2(100,0)
var rand

# Called when the node enters the scene tree for the first time.
func _ready():
	
	rand = randi_range(2,14)
	
	for n in 20:
		if rand == n:
			no_instanciar = true
		
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
