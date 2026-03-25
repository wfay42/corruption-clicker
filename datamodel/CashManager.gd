class_name CashManager extends Object


signal cash_changed(cash_value)
const CASH_CHANGED_NAME: String = "cash_changed"

const CASH_BASE_VALUE: float = 1.0

var _cash: float
var _cash_rate: float

func _init():
	_cash = 0.0
	_cash_rate = CASH_BASE_VALUE

func get_cash() -> float:
	return _cash

func emit_cash_changed() -> void:
	cash_changed.emit(_cash)

func increment() -> void:
	_cash += _cash_rate
	emit_cash_changed()

func reduce(amount: float) -> float:
	"""
	Reduce the amount of cash, and return the remaining cash.
	Cash cannot go below 0.0. If the transaction would leave negative cash,
	the transaction fails and a negative number is returned.
	"""
	if amount <= _cash:
		_cash -= amount
		emit_cash_changed()
		return _cash
	else:
		return -1.0

func onUpgradePurchased(upgradeId: String, upgrades: Upgrades) -> void:
	var cashRateFromUpgrades: int = upgrades.getOwnedCashPlusUpgradeValue()
	self._cash_rate = CASH_BASE_VALUE + cashRateFromUpgrades
