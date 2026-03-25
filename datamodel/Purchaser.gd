class_name Purchaser extends Object

signal upgradePurchased(upgradeId, Upgrades)
const UPGRADE_PURCHASED_NAME: String = "upgradePurchased"

var _purchaseMutex: Mutex

var _cashManager: CashManager
var _upgrades: Upgrades

func _init(cashManager: CashManager, upgrades: Upgrades) -> void:
	_cashManager = cashManager
	_upgrades = upgrades
	_purchaseMutex = Mutex.new()

func purchase_upgrade(upgradeId: String) -> bool:
	var upgradeData: Dictionary = Upgrades.getUpgrade(upgradeId)
	var success: bool = false
	if _upgrades.canPurchase(upgradeId, _cashManager.get_cash()):
		# lock while we try to purchase and append to upgrades on success
		_purchaseMutex.lock()
		var remainingCash: float = _cashManager.reduce(upgradeData[Upgrades.COST_KEY])

		if remainingCash >= 0.0:
			_upgrades.addUpgrade(upgradeId)
			success = true
		_purchaseMutex.unlock()

	# We wait to emit the signal down here so it is after the mutex unlocks.
	# Want to avoid a situation where the a thread ends up back in this method during the lock.
	if success:
		upgradePurchased.emit(upgradeId, _upgrades)
	return success