class_name Player extends Character

func _ready() -> void:
	Events.connect('move_player_by_path', self, '_on_move_player_by_path')
	set_process(false)

func _on_move_player_by_path(path: PoolVector2Array) -> void:
	print(['path', path])
	_path = path
	set_process(true)
	pass
