class_name Labyrinth extends Node2D

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
			
	return path

func _find_middle_point_if_needed(start: Vector2, end: Vector2):
	var start_map_position = tiles.world_to_map(start) 
	var end_map_position = tiles.world_to_map(end) 
	var diff: Vector2 = start_map_position - end_map_position
	
	if diff.x != 0 and diff.y != 0:
		return _find_middle_point(start_map_position, end_map_position)
		
	return null
	
func _find_middle_point(start: Vector2, end: Vector2) -> Vector2:
	var middle_point = Vector2(start.x, start.y)
	var direction_vector: Vector2 = start.direction_to(end)
	
	if direction_vector.x < 0 and direction_vector.y > 0:	
		middle_point.x = start.x  - 1
		
	if direction_vector.y < 0:
		middle_point.y = start.y - 1
		
	if direction_vector.x > 0 and direction_vector.y > 0:
		middle_point.x = start.x + 1
#		
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
	
func get_map_position(world_position: Vector2) -> Vector2:
	return tiles.world_to_map(world_position)
	
func get_world_positoin_base_on_event(event: InputEventScreenDrag) -> Vector2:
	return get_world_position(get_map_position(tiles.make_input_local(event).position))
	
func get_cell_corners_world_positoin(center: Vector2) -> Dictionary:
	return {
		"top_left": center - _half_cell_size,
		"bottom_right": center + _half_cell_size
	}

func has_passage(from: Vector2, to: Vector2) -> bool:
	var map_from = get_map_position(from)
	var map_to = get_map_position(to)
	var map_diff_abs = Vector2(abs(map_from.x - map_to.x), abs(map_from.y - map_to.y))
	var direction = DirectionEnum.get_diraction_base_on_positions(map_from, map_to)

	var from_value = LabyrinthTileMapHelper.get_cell_value(tiles, get_map_position(from))

	return !(from_value & direction) and map_diff_abs <= Vector2.ONE
