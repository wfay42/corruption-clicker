class_name UpgradeDict extends Object

"""
List of all upgrades
	Immutable Dictionary
	Maps numerical IDs to Upgrade object
"""

var _upgrades: Dictionary[int, UpgradeDescription]

var _nextId: int

func _init():
	_upgrades = {}
	_nextId = 0

func add(name: String, description: String, costs: Array[Cost], rate_change: CurrencyRate) -> void:
	var id = _nextId
	_upgrades[id] = UpgradeDescription.new(id, name, description, costs, rate_change)
	_nextId += 1

func get_upgrades() -> Dictionary[int, UpgradeDescription]:
	return _upgrades
	
func stringify_costs() -> String:
	var string_arr = PackedStringArray()
	for key in _upgrades.keys():
		var u = _upgrades[key]
		for cost: Cost in u._costs:
			var s = str(cost._amount) + " " + str(cost._currency)
			string_arr.append(s)
	return ", ".join(string_arr)
