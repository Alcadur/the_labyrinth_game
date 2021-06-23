class_name Character extends KinematicBody2D

export var speed: float = 150
var _delta_speed: float = 0
var _dystance: Vector2
var _destination_point := position
var _moving: Vector2
var _is_moving := false
var _path: PoolVector2Array = PoolVector2Array([])

func _ready() -> void:
	_disable_move()

func _process(delta) -> void:
	_delta_speed = delta * speed
	
	if _is_moving:
		move()
	
func _physics_process(delta: float) -> void:
	pass

func move_by_path(path: PoolVector2Array) -> void:
	path.remove(0)
	_path = path
	_enable_move()

func move() -> void:
	if !_path or _path.empty():
		_disable_move()
		return
	var destination := _path[0]
	var distance = position.distance_to(destination)
	_moving = position.direction_to(destination) * _delta_speed
	
	if distance > 2:
		var colision_obj = move_and_collide(_moving)
		return

	position = destination
	_path.remove(0)

func _enable_move() -> void:
	_is_moving = true

func _disable_move() -> void:
	_is_moving = false

func stop() -> void:
	if _path.empty():
		return

	_path = PoolVector2Array([_path[0]])
