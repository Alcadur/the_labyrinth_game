class_name Enemy extends Character

var _labyrinth: Labyrinth
var _line := Line2D.new()
var _is_aggressive := false
var _sight_range := 1
var _memory_size: = 3

func setup(labyrinth: Labyrinth) -> void:
	_labyrinth = labyrinth

func _ready():
	add_child(_line)
	pass # Replace with function body.

func _draw_path() -> void:
	_line.points = _path;
	pass
