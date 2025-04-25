class_name UpgradeDict extends Object

"""
List of all upgrades
	Immutable Dictionary
	Maps numerical IDs to Upgrade object
"""

var _upgrades: Dictionary[int, UpgradeDescription]

func _init():
	_upgrades = {}
	
func add(id: int, element: UpgradeDescription) -> void:
	_upgrades[id] = element
