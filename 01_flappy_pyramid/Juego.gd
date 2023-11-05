extends Node

@export var Tubo: PackedScene
	
func _on_timer_tubo_timeout():
	var e = Tubo.instantiate()
	add_child(e)
