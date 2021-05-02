class_name PlayerPath extends Line2D

var _labyrinth: Labyrinth
var _player: Player
var _can_move := false
var _path: Array = []

func setup(labyrinth: Labyrinth, player: Player) -> void:
	_labyrinth = labyrinth
	_player = player

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed: 
		_can_move = _was_clicked_nearby_to_player(event)

	if event is InputEventScreenTouch and !event.pressed:
		_can_move = false
		Events.emit_signal('move_player_by_path', _path)
		clear_points()
		_path.clear()

	if event is InputEventScreenDrag and _can_move:
		var cell_center = _labyrinth.get_world_positoin_base_on_event(event)
		_remove_points_to_doubeld_position(cell_center)
		if _path.size() == 0 or _labyrinth.has_passage(_path[-1], cell_center):
			_path.append(cell_center)

	points = PoolVector2Array(_path)
	

func _was_clicked_nearby_to_player(event: InputEventScreenTouch) -> bool:
	var player_position = _player.global_position
	var local_input_position = make_input_local(event).position	
	var corners = _labyrinth.get_cell_corners_world_positoin(player_position)
	var top_left_corner: Vector2 = corners.get(Consts.cell_top_left_corner)
	var botom_right_corner: Vector2 = corners.get(Consts.cell_bottom_right_corner)
	
	var grater_then_top_left = local_input_position.x > top_left_corner.x and local_input_position.y > top_left_corner.y
	var lower_then_bottom_right = local_input_position.x < botom_right_corner.x and local_input_position.y < botom_right_corner.y
	
	return grater_then_top_left and lower_then_bottom_right 
	
func _remove_points_to_doubeld_position(position: Vector2) -> void:
	if _path.has(position):
		_path.pop_back()
		_remove_points_to_doubeld_position(position)

func _ready():
	pass 
