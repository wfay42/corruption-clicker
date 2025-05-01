extends Node2D

signal corruption_changed(new_corruption)
const CORRUPTION_CHANGED_NAME = "corruption_changed"

signal dollars_changed(new_dollars)
const DOLLARS_CHANGED_NAME = "dollars_changed"

var _total_corruption = 0.0

var _corruption_click_value = 1.0
var _corruption_per_second = 5.0

var _currency_tracker: CurrencyTracker
var _upgrade_dict: UpgradeDict
var _worker_dict: UpgradeDict

func update_corruption_rate() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_currency_tracker = CurrencyTracker.new()
	_upgrade_dict = UpgradeDict.new()
	_worker_dict = WorkerUpgradeDict.create()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_currency_tracker.update(delta)
	emit_signal(CORRUPTION_CHANGED_NAME, _currency_tracker.get_labor())
	emit_signal(DOLLARS_CHANGED_NAME, _currency_tracker.get_dollars())

func _on_labor_button_pressed() -> void:
	# TODO: actually want this button to increment by 1, not update the rate,
	# but I did this to make sure the currencytracker was working
	_currency_tracker.get_labor_rate().add_to_base(1)
	
	# NOTE: we do not emit the CORRUPTION_CHANGED_NAME signal here because it
	# gets emitted after every _process call


func _on_dollar_button_pressed() -> void:
	if _currency_tracker.get_labor() >= 10:
		_currency_tracker.add_dollars(1)
		_currency_tracker.add_labor(-10)
