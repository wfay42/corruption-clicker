class_name CostOfPurchase extends Object

var _id: int
var _name: String
var _description: String
var _costs: Array[Cost]

func _init(id: int, name: String, description: String):
	_id = id
	_name = name
	_description = description
	_costs = []
	
func add_cost(cost: Cost):
	_costs.append(cost)
