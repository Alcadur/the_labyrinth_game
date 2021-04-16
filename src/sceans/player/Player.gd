extends KinematicBody2D

export var speed: float = 150
var _delta_speed: float = 0
var _dystance: Vector2
var _destination_point := position
var _is_moving := false
var _moving: Vector2
var _path: PoolVector2Array = PoolVector2Array([])

func _ready() -> void:
	set_process(false)

func _process(delta) -> void:
	_delta_speed = delta * speed
	
	if _path.size() == 0:
		set_process(false)
		return
	move()
	pass
	
func _physics_process(delta: float) -> void:
	pass

func _start_move(destination: Vector2) -> void:
	_destination_point = destination
	_is_moving = true

func _stop_move() -> void:
	_is_moving = false

func move_by_path(path: PoolVector2Array) -> void:
	path.remove(0)
	_path = path
	_is_moving = true
	set_process(true)

func move() -> void:
	if !_path or _path.size() == 0:
		return
	var destination := _path[0]
	var distance = position.distance_to(destination)
	_moving = position.direction_to(destination) * _delta_speed
	
	if distance > 2:
		var colisionObj = move_and_collide(_moving)
		
		if colisionObj != null:
			_stop_move()
		return

	_stop_move()
	position = destination
	_path.remove(0)
