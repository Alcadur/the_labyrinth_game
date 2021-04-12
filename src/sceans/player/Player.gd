extends KinematicBody2D

export var speed: float = 150
var _delta_speed: float = 0
var _dystance: Vector2
var _destination_point := position
var _is_moving := false
var _moving: Vector2

func _process(delta) -> void:
	_delta_speed = delta * speed
	move_if_required()
	pass
	
func _physics_process(delta: float) -> void:
	
	pass

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_start_move(event.position)

func move_if_required() -> void:
	if _is_moving == false: 
		return
	var distance = position.distance_to(_destination_point)
	_moving = position.direction_to(_destination_point) * _delta_speed

	if distance > 2:
		var colisionObj = move_and_collide(_moving)
		
		if colisionObj != null:
			_stop_move()
		return

	position = _destination_point

func _start_move(destination: Vector2) -> void:
	_destination_point = destination
	_is_moving = true

func _stop_move() -> void:
	_is_moving = false
