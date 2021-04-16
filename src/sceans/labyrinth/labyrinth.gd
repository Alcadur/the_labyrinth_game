extends Node2D

signal finished(cell_position)
onready var tiles: TileMap = $Navigation/TileMap
onready var nav: Navigation2D = $Navigation
onready var builder = LabyrinthBuilder.new(tiles, Vector2(10, 10))
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
	var simple_path = nav.get_simple_path(from, _convert_to_tile_center(to), false)
	var path = PoolVector2Array([])
	var simple_path_max_index = simple_path.size() - 1
	for step_index in range(simple_path_max_index + 1):
		var current_step = simple_path[step_index]
		path.append(_convert_to_tile_center(current_step))
		
		if step_index < simple_path_max_index:
			var next_step = simple_path[step_index + 1]
			var middle_step = _find_middle_point_if_needed(current_step, next_step)
			if middle_step != null: path.append(_convert_to_tile_center(middle_step))
			
	var map_path = []
	for p in path:
		map_path.append(tiles.world_to_map(p))
	print(['mpa_path', map_path])	
	print(['find_path', path])
	return path

func _find_middle_point_if_needed(start: Vector2, end: Vector2):
	var start_map_position = tiles.world_to_map(start) 
	var end_map_position = tiles.world_to_map(end) 
	var diff: Vector2 = start_map_position - end_map_position
	#print(['diff', start_map_position, end_map_position, diff])
	if diff.x != 0 and diff.y != 0:
		return _find_middle_point(start_map_position, end_map_position, diff)
		
	return null
	
func _find_middle_point(start: Vector2, end: Vector2, diff: Vector2) -> Vector2:
	var start_value = LabyrinthTileMapHelper.get_cell_value(tiles, start)
	var end_value = LabyrinthTileMapHelper.get_cell_value(tiles, end)
	var middle_point = Vector2(start.x, start.y)
	print(['positoins', start, end])
	print(['diff', diff])
	print(['values', start_value, end_value])
	print('directions', start.direction_to(end))
	var direction_vector: Vector2 = start.direction_to(end)
	
	if direction_vector.x < 0 and direction_vector.y > 0:	
		print('1')
		middle_point.x = start.x  - 1
		middle_point.y = start.y 
		
	if direction_vector.x > 0 and direction_vector.y < 0:
		print('2')
		middle_point.x = start.x
		middle_point.y = start.y - 1
	
	if direction_vector.x < 0 and direction_vector.y < 0:
		print(['3', start_value & DirectionEnum.N, end_value & DirectionEnum.E])
#		if ((start_value & DirectionEnum.N) == 0) and ((end_value & DirectionEnum.E) == 0):
		middle_point.x = start.x
		middle_point.y = start.y - 1
#		else:
#			middle_point.x = start.x - 1
#			middle_point.y = start.y
		
	if direction_vector.x > 0 and direction_vector.y > 0:
		print(['4 ', start_value & DirectionEnum.E])
#		if (start_value & DirectionEnum.E) == 0 and (end_value & DirectionEnum.N) == 0:
		middle_point.x = start.x + 1
		middle_point.y = start.y
#		else:
#			middle_point.x = start.x
#			middle_point.y = start.y + 1
	
	#if diff.x < 0 and diff.y < 0:
	#	print(['fmp', start_value & DirectionEnum.N])
	print(['middle', middle_point])
	return tiles.map_to_world(middle_point) 
		
	
func _convert_to_tile_center(tile_world_position: Vector2) -> Vector2:
	return tiles.map_to_world(tiles.world_to_map(tile_world_position)) + _half_cell_size
	
func _ready():
	set_process(false)
	pass

func manual_build(cells_values: PoolVector3Array) -> void:
	for cell_value in cells_values:
		LabyrinthTileMapHelper.set_cell_value(tiles, Vector2(cell_value.x, cell_value.y), cell_value.z)

func generate() -> void: 
	builder.set_offset(Vector2(2, 1)).prepare()
	set_process(true)

func get_world_position(map_positoin: Vector2) -> Vector2:
	return tiles.map_to_world(map_positoin) + _half_cell_size
