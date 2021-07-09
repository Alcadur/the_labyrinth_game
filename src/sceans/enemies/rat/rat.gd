class_name Rat extends Enemy

#var _labyrinth: Labyrinth
#var _delta_acc: float = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	speed = 50
	pass # Replace with function body.

#func _process(delta):
#	if !_is_moving:
#		go_to_next_cell()
		
#func go_to_next_cell() -> void:
#	var map_position = _labyrinth.get_map_position(position)
#	var new_p = Vector2(position.x + _labyrinth._half_cell_size.x, position.y)
#	var path = _labyrinth.find_path(map_position, new_p)
#	if path.size() == 0:
#		path = _labyrinth.find_path(position, _labyrinth.get_world_position(Vector2(map_position.x, map_position.y + 1)))
#	print(['enemy path', path])
#	move_by_path(path)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
