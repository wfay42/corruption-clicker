class_name CashManagerView extends Object

"""A view into the read-only methods of CashManager"""

var _cashManager: CashManager

func _init(cashManager: CashManager) -> void:
	_cashManager = cashManager

func get_cash() -> float:
	return _cashManager.get_cash()
