extends ItemList

"""
Keep track of available upgrades in two Arrays with the same indexing
1. Array of Upgrades stored internally
2. Array of Items in the UI Item List
"""

var _upgrades: Upgrades = null
var _cashManager: CashManagerView = null

func _ready() -> void:
	pass

func setup(upgrades: Upgrades, cashManager: CashManagerView) -> void:
	"""Initializes the upgrade list with the given Upgrades and CashManagerView
	"""
	_upgrades = upgrades
	_cashManager = cashManager

func refreshList() -> void:
	"""Refreshes the list of upgrades based on the current state of owned upgrades
	"""
	if (_upgrades == null):
		return

	self.clear()
	var availableUpgrades: Array[Dictionary] = _upgrades.getAllAvailableUpgrades()
	for upgradeData in availableUpgrades:
		var displayText: String = "$%d - %s" % [upgradeData[Upgrades.COST_KEY], upgradeData[Upgrades.NAME_KEY]]
		var idx = self.add_item(displayText)
		self.set_item_metadata(idx, upgradeData)
		self.set_item_tooltip(idx, upgradeData[Upgrades.DESCRIPTION_KEY])

func _on_item_activated(index: int) -> void:
	"""What to do when an item is double clicked
	"""
	var item_name: String = self.get_item_text(index)
	print("Activated item: %s" % item_name)

	var upgradeData: Dictionary = self.get_item_metadata(index)
	var upgradeId: String = upgradeData[Upgrades.ID_KEY]

	var success: bool = _upgrades.tryPurchase(upgradeId, _cashManager.get_cash())
	print("Attempted to purchase upgrade %s, success: %s" % [upgradeId, success])
	if (success):
		refreshList() # Refresh the list to reflect the newly purchased upgrade
