class_name LabyrinthTileMapHelper

const _map = {
	0: 18, # empty
	1: 1, # N
	2: 2, # E
	3: 5, # N + E
	4: 3, # S
	5: 6, # N + S
	6: 8, # E + S
	7: 13, # N + E + S
	8: 4, # W
	9: 7, # W + N
	10: 9, # E + W
	11: 12, # N + E + W
	12: 10, # S + W
	13: 11, # N + S + W 
	14: 14, # E + S + W
	15: 15, # N + E + S + W
}

static func get_tile_id(field_value: int) -> int:
	return _map[field_value]

static func set_cell_value(map: TileMap, position: Vector2, value) -> void:
	map.set_cellv(position, get_tile_id(value))

static func get_random_direction() -> int:
	var dirs = [DirectionEnum.N, DirectionEnum.E, DirectionEnum.S, DirectionEnum.W]
	randomize()
	dirs.shuffle()
	return dirs[0]

static func get_cell_value(map: TileMap, position: Vector2) -> int:
	var value = map.get_cellv(position)
	for key in _map.keys():
		if _map[key] == value:
			return key
	return -1
	
static func get_cell_value_or_max(map: TileMap, positoin: Vector2) -> int:
	var value = get_cell_value(map, positoin)
	if value == -1: 
		return DirectionEnum.N + DirectionEnum.E + DirectionEnum.S + DirectionEnum.W
	return value
