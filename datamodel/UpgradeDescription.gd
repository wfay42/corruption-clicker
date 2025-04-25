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
var _description: String
var _costs: Array[Cost]
var _rate_change: CurrencyRate
	
func _init(id: int, name: String, description: String, costs: Array[Cost], rate_change: CurrencyRate):
	_id = id
	_name = name
	_description = description
	_costs = costs
	_rate_change = rate_change

func stringify_costs(intify: bool = true) -> String:
	var string_arr = PackedStringArray()
	for cost: Cost in _costs:
		var amount = str(int(cost._amount) if intify else cost._amount)
		var s = amount + " " + str(cost._currency._name)
		string_arr.append(s)
	return ", ".join(string_arr)
