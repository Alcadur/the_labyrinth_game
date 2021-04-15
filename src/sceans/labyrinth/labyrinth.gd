extends Node2D

signal finished(cell_position)
onready var tiles: TileMap = $Navigation/TileMap
onready var nav: Navigation2D = $Navigation
onready var builder = LabyrinthBuilder.new(tiles, Vector2(4, 4))
onready var _half_cell_size: Vector2 = tiles.cell_size / 2
var entry_cell_positoin: Vector2

func _process(delta):
	if builder.has_steps():
		builder.step()
		print(builder.progress)
	
	if builder.progress == 1:
		set_process(false)
		var entry_map_position = builder.set_entry(DirectionEnum.S)
		var entry_center_world_position = tiles.map_to_world(entry_map_position) + _half_cell_size
		
		emit_signal('finished', entry_center_world_position)

func find_path(from: Vector2, to: Vector2) -> PoolVector2Array:
	var to_cell_center = tiles.map_to_world(tiles.world_to_map(to)) + _half_cell_size
	
	print(['find_path', nav.get_simple_path(from, to, false)])
	return nav.get_simple_path(from, to, false)

func _ready():
	builder.set_offset(Vector2(2, 1)).prepare()
	pass
