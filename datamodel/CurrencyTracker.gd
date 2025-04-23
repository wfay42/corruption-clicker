class_name CurrencyTracker extends Object

const DOLLAR_IDX = 0
const LABOR_IDX = 1
const MIGHT_IDX = 2

static var DOLLAR = Currency.new(DOLLAR_IDX, "Dollars", "Money.")
static var LABOR = Currency.new(LABOR_IDX, "Labor", "How much stuff you can make.")
static var MIGHT = Currency.new(MIGHT_IDX, "Might", "How powerful you are.")

var _currencies: Dictionary[int, Currency]
var _currency_values: Dictionary[int, float]
var _currency_rates: Dictionary[int, CurrencyRate]

func _init():
	_currencies = {}
	_currencies[DOLLAR_IDX] = DOLLAR
	_currencies[LABOR_IDX] = LABOR
	_currencies[MIGHT_IDX] = MIGHT
	
	_currency_values = {}
	for currency_idx in _currencies.keys():
		_currency_values[currency_idx] = 0.0
		_currency_rates[currency_idx] = CurrencyRate.new(0.0, 1.0)

func add_currency_amount(currency_idx: int, amount: float) -> float:
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

## Convenience functions for easier typing, which is OK since there's currently
## Only three currency types
func add_dollars(amount: float) -> float:
	return add_currency_amount(DOLLAR_IDX, amount)
func add_labor(amount: float) -> float:
	return add_currency_amount(LABOR_IDX, amount)
func add_might(amount: float) -> float:
	return add_currency_amount(MIGHT_IDX, amount)
	
func get_dollars() -> float:
	return get_currency_amount(DOLLAR_IDX)
func get_labor() -> float:
	return get_currency_amount(LABOR_IDX)
func get_might() -> float:
	return get_currency_amount(MIGHT_IDX)
	
func update(delta: float) -> void:
	"""
	Update the current currencies based on the currency rates times the time delta
	"""
	for currency_idx in _currencies.keys():
		var value = _currency_rates[currency_idx].calculate_value(delta)
		add_currency_amount(currency_idx, value)
