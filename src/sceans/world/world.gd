extends Node2D

onready var player := $Player
onready var labyrinth := $Labyrinth
onready var path_visualization := $PathVisualiation

func _ready() -> void:
	labyrinth.connect("finished", self, "_on_Labyrinth_finish")
#	labyrinth.generate()
	labyrinth.camera = $Camera2D
#	labyrinth.manual_build([
#		Vector3(2, 2, 15 - 4),
#		Vector3(3, 2, 15 - 4),
#		Vector3(4, 2, 15 - 2),
#		Vector3(5, 2, 15 - 8 - 4),
#
#		Vector3(2, 3, 15 - 1 - 2),
#		Vector3(3, 3, 15 - 1 - 2 -8),
#		Vector3(4, 3, 15 - 8 - 4),
#		Vector3(5, 3, 15 - 1 - 4),
#
#		Vector3(2, 4, 15 - 2 - 4),
#		Vector3(3, 4, 15 - 8),
#		Vector3(4, 4, 15 - 1 -2),
#		Vector3(5, 4, 15 - 1 - 4 - 8),
#
#		Vector3(2, 5, 15 - 2 - 1),
#		Vector3(3, 5, 15 - 4 - 2 - 8),
#		Vector3(4, 5, 15 - 2 - 8),
#		Vector3(5, 5, 15 - 8 - 1),
#	])
#	player.position = labyrinth.get_world_position(Vector2(3, 5))
	#player.position = labyrinth.get_world_position(Vector2(4, 3))

func _on_Labyrinth_finish(cell_position) -> void:
	player.position = cell_position
	
