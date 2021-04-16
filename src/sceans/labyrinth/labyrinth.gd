extends Node2D

signal finished(cell_position)
onready var tiles: TileMap = $Navigation/TileMap
onready var nav: Navigation2D = $Navigation
onready var builder = LabyrinthBuilder.new(tiles, Vector2(8, 8))
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
	var simple_path = nav.get_simple_path(from, to, false)
	var path = PoolVector2Array([])
	var simple_path_max_index = simple_path.size() - 1
	for step_index in range(simple_path_max_index):
		var current_step = simple_path[step_index]
		if step_index < simple_path_max_index:
			var next_step = simple_path[step_index + 1]
			
		path.append(_convert_to_tile_center(current_step))

	print(['find_path', path])
	return path

func _find_middle_point_if_needed(start: Vector2, end: Vector2):
	var start_map_position = tiles.world_to_map(start) 
	var end_map_position = tiles.world_to_map(end) 
	var diff: Vector2 = start_map_position - end_map_position

	if diff.x != 0 and diff.y != 0:
		return _find_middle_point(start_map_position, diff)
		
	return null
	
func _find_middle_point(map_positoin, diff) -> Vector2:
	
func _convert_to_tile_center(tile_world_position: Vector2) -> Vector2:
	print(['map position', tiles.world_to_map(tile_world_position)])
	return tiles.map_to_world(tiles.world_to_map(tile_world_position)) + _half_cell_size
	
func _ready():
	builder.set_offset(Vector2(2, 1)).prepare()
	pass
