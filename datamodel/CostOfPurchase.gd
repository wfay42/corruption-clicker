class_name CostOfPurchase extends Object

var _name: String
var _description: String
var _costs: Array[Cost]

func _init(name: String):
	_name = name
	_costs = []
	
func add_cost(cost: Cost):
	_costs.append(cost)
