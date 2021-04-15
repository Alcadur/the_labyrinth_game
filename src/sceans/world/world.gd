extends Node2D

onready var player := $Player
onready var labyrinth := $Labyrinth

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var path = labyrinth.find_path(player.global_position, event.position)
		player.move_by_path(path)
		print(['path', path])

func _ready() -> void:
	labyrinth.connect("finished", self, "_on_Labyrinth_finish")

func _on_Labyrinth_finish(cell_position) -> void:
	player.position = cell_position
