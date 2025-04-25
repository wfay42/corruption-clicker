class_name CurrencyTracker extends Object
"""
Tracks a few things
- The defined currencies
- Rate of currency growth
- Currency in your wallet
"""

enum CurrencyId {DOLLAR_ID, LABOR_ID, MIGHT_ID}

static var DOLLAR = Currency.new(CurrencyId.DOLLAR_ID, "Dollars", "Money.")
static var LABOR = Currency.new(CurrencyId.LABOR_ID, "Labor", "How much stuff you can make.")
static var MIGHT = Currency.new(CurrencyId.MIGHT_ID, "Might", "How powerful you are.")

var _currencies: Dictionary[CurrencyId, Currency]
var _currency_values: Dictionary[CurrencyId, float]
var _currency_rates: Dictionary[CurrencyId, CurrencyRate]

func _init():
	_currencies = {}
	_currencies[CurrencyId.DOLLAR_ID] = DOLLAR
	_currencies[CurrencyId.LABOR_ID] = LABOR
	_currencies[CurrencyId.MIGHT_ID] = MIGHT
	
	_currency_values = {}
	for currency_idx in _currencies.keys():
		_currency_values[currency_idx] = 0.0
		_currency_rates[currency_idx] = CurrencyRate.new(0.0, 1.0)

func add_currency_amount(currency_idx: CurrencyId, amount: float) -> float:
	"""
	Returns the amount after adding
	"""
	var new_amount = _currency_values[currency_idx] + amount
	_currency_values[currency_idx] = new_amount
	return new_amount

func get_currency_amount(currency_idx: int) -> float:
	return _currency_values[currency_idx]

func get_currency_description(currency_idx: int) -> Currency:
	return _currencies[currency_idx]
	
func get_currency_rate(currency_idx: int) -> CurrencyRate:
	return _currency_rates[currency_idx]

## Convenience functions for easier typing, which is OK since there's currently
## Only three currency types
func add_dollars(amount: float) -> float:
	return add_currency_amount(CurrencyId.DOLLAR_ID, amount)
func add_labor(amount: float) -> float:
	return add_currency_amount(CurrencyId.LABOR_ID, amount)
func add_might(amount: float) -> float:
	return add_currency_amount(CurrencyId.MIGHT_ID, amount)
	
func get_dollars() -> float:
	return get_currency_amount(CurrencyId.DOLLAR_ID)
func get_labor() -> float:
	return get_currency_amount(CurrencyId.LABOR_ID)
func get_might() -> float:
	return get_currency_amount(CurrencyId.MIGHT_ID)
	
func get_dollar_rate() -> CurrencyRate:
	return get_currency_rate(CurrencyId.DOLLAR_ID)
func get_labor_rate() -> CurrencyRate:
	return get_currency_rate(CurrencyId.LABOR_ID)
func get_might_rate() -> CurrencyRate:
	return get_currency_rate(CurrencyId.MIGHT_ID)
	
func update(delta: float) -> void:
	"""
	Update the current currencies based on the currency rates times the time delta
	"""
	for currency_idx in _currencies.keys():
		var value = _currency_rates[currency_idx].calculate_value(delta)
		add_currency_amount(currency_idx, value)
