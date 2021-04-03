extends Node2D

onready var tiles := $TileMap
var dirs = {
	"W": 0x1,
	"N": 0x2,
	"E": 0x4,
	"S": 0x8
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#var c = $TileMap.get_cellv(Vector2(0,0))
	$TileMap.set_cellv(Vector2(0,0), -1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
