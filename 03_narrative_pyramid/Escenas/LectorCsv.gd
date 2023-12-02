extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var groupname=""
	#var file = File.new()
	#file.open("res://CSV/dialgos.csv", file.READ)
	
	var file = FileAccess.open("res://CSV/dialgos.csv", FileAccess.READ)
	print("ASDASDQW")
	while !file.eof_reached():
		var csv = file.get_csv_line ()
		print(csv)
		if csv.size()>=7:
			
			if csv[2] != groupname:
				groupname=csv[2]
	file.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
