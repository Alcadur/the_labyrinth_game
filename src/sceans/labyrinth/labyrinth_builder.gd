class_name LabyrinthBuilder

var _map: TileMap
var _number_of_cells := 0
var _size: Vector2
var _last_x_index: int
var _last_y_index: int
var _offset := Vector2.ZERO
var _available := []
var _visited = {}
var _number_of_visited_cells := 0
var _random := RandomNumberGenerator.new()
var progress setget , _count_progress
var _entry: Vector2
var _exit: Vector2

func _init(map: TileMap, size: Vector2):
	_map = map
	_size = size
	_number_of_cells = size.x * size.y

func _count_progress() -> float:
	return float(_number_of_visited_cells) / float(_number_of_cells)

func set_offset(offset: Vector2) -> LabyrinthBuilder:
	_offset = offset
	return self

func build() -> void:
	prepare()
	while has_steps():
		step()

func prepare() -> LabyrinthBuilder: 
	_last_x_index = _size.x + _offset.x - 1
	_last_y_index = _size.y + _offset.y - 1
	_available = []
	_visited = {}
	_mark_rendom_cell_as_available()
	return self
			
func _mark_rendom_cell_as_available() -> void: 
	_random.randomize()
	var x = _random.randi_range(0 + _offset.x, _size.x + _offset.x - 1)
	var y = _random.randi_range(0 + _offset.y, _size.y + _offset.y - 1)
	var position = Vector2(x, y)
	_available.append(position)
	_add_to_visited(position)
	
func _add_to_visited(position: Vector2) -> void:
	if 	!_visited.has(position.x):
		_visited[position.x] = {}
	_visited[position.x][position.y] = true
	_number_of_visited_cells += 1
	
func has_steps() -> bool:
	return _available.size() > 0

func step() -> void:
	if !has_steps():
		return
	
	var current_cell = _get_available_cell()
	var next_cell = _get_next_cell_position(current_cell)
	
	if next_cell == Vector2.INF:
		_remove_unnecessary_cells_from_availables(current_cell)
		return
	
	_add_to_visited(next_cell)
	_remove_walls(current_cell, next_cell)
	
	if _get_unvisited_neighbors(next_cell).size() > 0:
		_available.append(next_cell)
		
	_remove_unnecessary_cells_from_availables(current_cell)	
		
func _get_available_cell() -> Vector2:
	_random.randomize()
	var cell_index = _random.randi_range(0, _available.size() - 1)
	return _available[cell_index]
	
func _get_next_cell_position(current_cell: Vector2) -> Vector2: 
	_random.randomize()
	
	var neighbors = _get_unvisited_neighbors(current_cell)
	if neighbors.size() == 0: 
		return Vector2.INF
		
	var neighbor_index = _random.randi_range(0, neighbors.size() - 1)
	return neighbors[neighbor_index]
	
func _get_unvisited_neighbors(position: Vector2) -> PoolVector2Array:
	var neighbor_N = Vector2(position.x, position.y + 1)
	var neighbor_E = Vector2(position.x + 1, position.y)
	var neighbor_S = Vector2(position.x, position.y - 1)
	var neighbor_W = Vector2(position.x - 1, position.y)
	var all_neighbors := PoolVector2Array([neighbor_N, neighbor_E, neighbor_S, neighbor_W])
	return _remove_visited_and_incorect_neighbors(all_neighbors)

func _remove_visited_and_incorect_neighbors(neighbors: PoolVector2Array) -> PoolVector2Array:
	var correct_neighbors = PoolVector2Array([]);
	
	for neighbor in neighbors:
		var correct_x: bool = neighbor.x >= _offset.x and neighbor.x < _size.x + _offset.x
		var correct_y: bool = neighbor.y >= _offset.y and neighbor.y < _size.y + _offset.y
		var not_visited: bool = !_was_visited(Vector2(neighbor.x, neighbor.y))
		if correct_x and correct_y and not_visited:
			correct_neighbors.append(Vector2(neighbor.x, neighbor.y))
			
	return correct_neighbors

func _was_visited(positoin: Vector2) -> bool:
	if !_visited.has(positoin.x):
		return false
	
	return _visited[positoin.x].has(positoin.y)

func _remove_walls(current_cell: Vector2, next_cell: Vector2) -> void:
	var direction = DirectionEnum.get_diraction_base_on_positions(current_cell, next_cell)
	_remove_wall(current_cell, direction)
	_remove_wall(next_cell, DirectionEnum.oposit(direction))

func _remove_wall(positoin: Vector2, direction) -> void: 
	var cell_value = LabyrinthTileMapHelper.get_cell_value_or_max(_map, positoin)
	LabyrinthTileMapHelper.set_cell_value(_map, positoin, cell_value - direction)

func _remove_unnecessary_cells_from_availables(position: Vector2) -> void: 
	var cells = [
		position,
		Vector2(position.x + 1, position.y),
		Vector2(position.x - 1, position.y),
		Vector2(position.x, position.y + 1),
		Vector2(position.x, position.y - 1),
	]
	
	for cell in cells:
		if _get_unvisited_neighbors(cell).size() == 0:
			_remove_from_available(cell)
			
func _remove_from_available(positoin: Vector2) -> void:
	_available.remove(_available.find(positoin))
	
func set_entry(directoin: int, cell_index: int = -1) -> Vector2:
	_random.randomize()
	var positions := PoolVector2Array([])
	var x_range := range(_offset.x, _last_x_index)
	var y_range := range(_offset.y, _last_y_index)
	
	match directoin:
		DirectionEnum.N: 
			for x in x_range:
				positions.append(Vector2(x, _offset.y))
		DirectionEnum.E: 
			for y in y_range:
				positions.append(Vector2(_last_x_index, y))
		DirectionEnum.S: 
			for x in x_range:
				positions.append(Vector2(x, _last_y_index))
		DirectionEnum.W:
			for y in y_range:
				positions.append(Vector2(_offset.x, y))
	
	if cell_index == -1:
		cell_index = _random.randi_range(0, positions.size() - 1)

	_entry = positions[cell_index]
	_remove_wall(_entry, directoin)
	
	return _entry
