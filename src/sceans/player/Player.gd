extends KinematicBody2D

export var max_speed: float = 150
var _dystance: Vector2
var _destination_point := position
var _is_moving := false
var _speed := 0.0
var _movment: Vector2

func _process(delta) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_if_required(delta)

func _unhandled_input(event) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_destination_point = get_global_mouse_position()
		_is_moving = true

func move_if_required(delta: float) -> void:
	if _is_moving == false: 
		_speed = 0
		return
		
	_speed = max_speed

	var distance_to_destination = position.distance_to(_destination_point)
	_movment = position.direction_to(_destination_point) * _speed
	
	if distance_to_destination > 5:
		_movment = move_and_slide(_movment)
		return
	
	position = _destination_point
	_is_moving = false
