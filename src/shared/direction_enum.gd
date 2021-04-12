class_name DirectionEnum
const N = 1
const E = 2
const S = 4
const W = 8

static func oposit(direction: int) -> int:
	match direction:
		N: return S
		E: return W
		S: return N
		W: return E
	return 0

static func as_array() -> PoolIntArray:
	return PoolIntArray([N, E, S, W])

static func get_diraction_base_on_positions(position1: Vector2, position2: Vector2) -> int:
	if position1.y > position2.y:
		return N
	if position1.x < position2.x:
		return E
	if position1.y < position2.y: 
		return S
	if position1.x > position2.x:
		return W
	
	return 0
