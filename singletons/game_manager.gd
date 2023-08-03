extends Node

signal popped(node)

var num_list: Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 , 13, 14, 15 ,16 ,17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

var _score: float = 0
var _high_score: float = 0
var _running: bool = false

func get_score() -> float: 
	return _score
	
func get_high_score() -> float:
	return _high_score
	
func set_score(v: float) -> void:
	_score = v
	if _score < _high_score:
		_high_score = _score

func set_running(b: bool) -> void:
	_running  = b
