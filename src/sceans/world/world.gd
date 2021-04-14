extends Node2D

onready var player := $Player
onready var labyrinth := $Labyrinth

func _ready() -> void:
	labyrinth.connect("finished", self, "_on_Labyrinth_finish")

func _on_Labyrinth_finish(cell_position) -> void:
	player.position = cell_position
