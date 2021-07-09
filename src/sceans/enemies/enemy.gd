class_name Enemy extends Character

var _labyrinth: Labyrinth
var _line := Line2D.new()
var _is_aggressive := false
var _sight_range := 3
var _random = RandomNumberGenerator.new()
var _visited := []


func setup(labyrinth: Labyrinth) -> void:
	_labyrinth = labyrinth

func _process(delta):
	_draw_path()	

func _physics_process(delta) -> void:
	if !_is_moving:
		_make_next_step()
	pass

func _ready() -> void:
	#_path = _labyrinth.find_path(position, _labyrinth.get_world_position(Vector2(8, 8)))
#	_line.global_position = Vector2.ZERO
#	_labyrinth.add_child(_line)
#	move_by_path(_path)
	pass

func _make_next_step() -> void:
	_random.randomize()
#	var next_cell = position #passages[_random.randi_range(0, passages.size() - 1)]
	
	var passages = _labyrinth.get_available_cells(position, PoolVector2Array(_visited))
	print(['passages', passages])
	if passages.empty():
#		_visited.pop_front()
		_visited.clear()
		_visited.append(position)
		passages = _labyrinth.get_available_cells(position)

	var next_cell = passages[_random.randi_range(0, passages.size() - 1)]
	_visited.append(next_cell)
	
	print(['next_cell', next_cell])
	
	move_by_path(PoolVector2Array([position, next_cell]))
	pass

# for debug only
func _draw_path() -> void:
	_line.points = _path;
	pass
