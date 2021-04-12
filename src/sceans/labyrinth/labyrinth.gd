extends Node2D

onready var tiles := $Navigation/TileMap
onready var nav := $Navigation2D
onready var builder = LabyrinthBuilder.new(tiles, Vector2(10, 10))

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		builder.step()

func _ready():
	builder.set_offset(Vector2(2, 2)).prepare()
	pass
