extends Node2D

onready var tiles := $TileMap
var dirs = {
	"N": 0x1,
	"E": 0x2,
	"S": 0x4,
	"W": 0x8
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var map = $LabyrinthTileMap
	#var c = $TileMap.get_cellv(Vector2(0,0))
	#$TileMap.set_cellv(Vector2(0,0), -1)
	print( [dirs.E, dirs.N,  dirs.E|dirs.N])
	#LabyrinthTileMapHelper.set_cell_value(map, Vector2(2, 2), dirs.N|dirs.E|dirs.S|dirs.W)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(1, 1), dirs.N)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(3, 1), dirs.E)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(5, 1), dirs.S)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(7, 1), dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(9, 1), dirs.N|dirs.E)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(11, 1), dirs.N|dirs.S)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(13, 1), dirs.N|dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(15, 1), dirs.E|dirs.S)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(17, 1), dirs.E|dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(19, 1), dirs.S|dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(1, 3), dirs.N|dirs.E|dirs.S)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(3, 3), dirs.N|dirs.E|dirs.W)
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(5, 3), dirs.N|dirs.S|dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(7, 3), dirs.E|dirs.S|dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(9, 3), dirs.N|dirs.E|dirs.S|dirs.W)
	
	LabyrinthTileMapHelper.set_cell_value(map, Vector2(1, 5), dirs.N|dirs.E|dirs.S|dirs.W)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
