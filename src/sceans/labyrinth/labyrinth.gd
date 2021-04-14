extends Node2D

signal finished(cell_position)
onready var tiles := $Navigation/TileMap
onready var nav := $Navigation2D
onready var builder = LabyrinthBuilder.new(tiles, Vector2(20, 12))
var entry_cell_positoin: Vector2

func _process(delta):
	if builder.has_steps():
		builder.step()
		print(builder.progress)
	
	if builder.progress == 1:
		set_process(false)
		var entry_map_position = builder.set_entry(DirectionEnum.S)
		var entry_center_world_position = tiles.map_to_world(entry_map_position) + (tiles.cell_size / 2)
		
		emit_signal('finished', entry_center_world_position)

func _ready():
	builder.set_offset(Vector2(2, 1)).prepare()
	pass
