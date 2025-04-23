class_name CurrencyRate extends Object
"""
The rate at which a currency automatically increases
"""

var _base: float
var _multiplier: float

func _init(base: float, multiplier: float):
	_base = base
	_multiplier = multiplier
	
func get_base() -> float:
	return _base
func get_multiplier() -> float:
	return _multiplier
	
func set_base(base: float) -> void:
	_base = base
func set_multiplier(multiplier: float) -> void:
	_multiplier = multiplier

func calculate_value(delta: float = 1.0) -> float:
	return _base * _multiplier * delta
