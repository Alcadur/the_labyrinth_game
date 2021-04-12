extends Node2D

onready var tiles := $Navigation/TileMap
onready var nav := $Navigation2D
onready var builder = LabyrinthBuilder.new(tiles, Vector2(25, 25))

func _process(delta):
	if builder.has_steps():
		builder.step()
		print(builder.progress)

func _ready():
	builder.set_offset(Vector2(0, 0)).prepare()
	pass
