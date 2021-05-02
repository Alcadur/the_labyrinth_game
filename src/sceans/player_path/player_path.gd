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
		if _path.size() == 0 or (!_path.has(cell_center) and _labyrinth.has_passage(_path[-1], cell_center)):
			_path.append(cell_center)
	points = PoolVector2Array(_path)
	

func _was_clicked_nearby_to_player(event: InputEventScreenTouch) -> bool:
	var player_position = _player.global_position
	var lcoal_input_position = make_input_local(event).position	
	var corners = _labyrinth.get_cell_corners_world_positoin(player_position)
	return lcoal_input_position > corners.get('top_left') and lcoal_input_position < corners.get('bottom_right') 
	
func _ready():
	pass 
