class_name Player extends Character

var is_standing_by := false setget , _is_standing_by_getter

func _ready() -> void:
	Events.connect('move_player_by_path', self, '_on_move_player_by_path')

func _on_move_player_by_path(path: PoolVector2Array) -> void:
	print(['path', path])
	_path = path
	_enable_move()
	pass

func _is_standing_by_getter() -> bool:
	return !_is_moving
