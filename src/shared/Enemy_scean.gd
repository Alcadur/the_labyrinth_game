extends Node

var Rat = load(_generate_path('rat'))

func _generate_path(enemy_name):
	return 'res://src/sceans/enemies/' + enemy_name + '/' + enemy_name + '.tscn'
