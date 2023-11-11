extends Area2D

@export var Bloque: PackedScene
@export var vel = 100
var i = 0
var no_instanciar = false
var mov = Vector2(100,0)
var rand
var fin = false

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
		
func _process(delta):
	if fin == false:
		position -= mov*delta
	
func _signal_fin_tubo():
	fin = true
	
#Con esto cuando salga de la ventana el objeto desaparecera
func _on_visible_screen_exited():
	queue_free()
