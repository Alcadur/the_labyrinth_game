extends Line2D

var player: Player 
var labyrinth: Labyrinth
var _drag_start: Vector2
var path := PoolVector2Array([])
var camera: Camera2D

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_drag_start = event.position
	if event is InputEventScreenTouch and !event.pressed:
		_drag_start = Vector2.INF
		print(['up'])
		
	if event is InputEventScreenDrag:
		var map_position = labyrinth.get_map_position(event.position	)
		LabyrinthTileMapHelper.set_cell_value(labyrinth.tiles, map_position, 0)
		print(['lp', map_position, event.position])
#		var ltc = player.global_position - labyrinth.half_cell_size
#		var rbc = player.global_position + labyrinth.half_cell_size
#		print(['scale', scale])
#		print(['sc', event.position, event.position * scale])
#		add_point(event.position)
#
#		if _drag_start > ltc and _drag_start < rbc:
#			print(['drag', event.position])
		

func _ready():
#	position = Vector2.ZERO
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
