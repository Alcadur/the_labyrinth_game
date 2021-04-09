class_name LabyrinthTileMapHelper

const _map = {
	0: 0, # empty
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
