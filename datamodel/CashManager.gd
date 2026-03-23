class_name CashManager extends Object

const CASH_BASE_VALUE: float = 1.0

var _cash: float
var _cash_rate: float

func _init():
	_cash = 0.0
	_cash_rate = CASH_BASE_VALUE

func get_cash() -> float:
	return _cash

func increment() -> void:
	_cash += _cash_rate

func onUpgradePurchased(upgradeId: String, upgrades: Upgrades) -> void:
	var cashRateFromUpgrades: int = upgrades.getOwnedCashPlusUpgradeValue()
	self._cash_rate = CASH_BASE_VALUE + cashRateFromUpgrades
