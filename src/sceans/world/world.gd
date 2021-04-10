extends Node2D

onready var labyrinth := $Labyrinth
onready var nav := $Navigation2D2
onready var player := $Player

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		print('nav', nav.get_simple_path(Vector2.ZERO, event.position))
