extends ItemList

"""
Keep track of available upgrades in two Arrays with the same indexing
1. Array of Upgrades stored internally
2. Array of Items in the UI Item List
"""

var _upgrades: Upgrades = null

func _ready() -> void:
	pass

func set_upgrades(upgrades: Upgrades) -> void:
	_upgrades = upgrades

func refreshList() -> void:
	"""Refreshes the list of upgrades based on the current state of owned upgrades
	"""
	if (_upgrades == null):
		return

	self.clear()
	var availableUpgrades: Array[Dictionary] = _upgrades.getAllAvailableUpgrades()
	for upgradeData in availableUpgrades:
		var displayText: String = "%s - %s (Cost: $%d)" % [upgradeData["name"], upgradeData["description"], upgradeData["cost"]]
		self.add_item(displayText)

func _on_item_activated(index: int) -> void:
	"""What to do when an item is double clicked
	"""
	var item_name: String = self.get_item_text(index)
	print("Activated item: %s" % item_name)
