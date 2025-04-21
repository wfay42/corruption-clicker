class_name UpgradeDescription extends Object

"""
class UpgradeDescription
	int id
	String name
	float cost
	func whatItDoes - necessitates a way to run all of these functions at runtime
"""
	
var _id: int
var _name: String
var _cost
var _multiplier
	
func _init(id: int, name: String, cost: int):
	_id = id
	_name = name
	_cost = cost
	_multiplier = 1.0
	
