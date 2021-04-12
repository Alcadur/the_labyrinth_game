extends Node2D

onready var tiles := $Navigation/TileMap
onready var nav := $Navigation2D
onready var builder = LabyrinthBuilder.new(tiles, Vector2(50, 50))

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		tiles.clear()
		builder.prepare()

func _process(delta):
	if builder.has_steps():
		builder.step()
	pass

func _ready():
	builder.set_offset(Vector2(-32, -20)).prepare()
	pass
