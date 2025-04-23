extends Node2D

signal corruption_changed(new_corruption)
const CORRUPTION_CHANGED_NAME = "corruption_changed"

var _total_corruption = 0.0

var _corruption_click_value = 1.0
var _corruption_per_second = 5.0

var _currency_tracker: CurrencyTracker
var _upgrade_list: UpgradeList

func update_corruption_rate() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_currency_tracker = CurrencyTracker.new()
	_upgrade_list = UpgradeList.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_currency_tracker.add_dollars(_corruption_per_second * delta)
	emit_signal(CORRUPTION_CHANGED_NAME, _currency_tracker.get_dollars())

func _on_corruption_button_pressed() -> void:
	_currency_tracker.add_dollars(_corruption_click_value)
	
	# NOTE: we do not emit the CORRUPTION_CHANGED_NAME signal here because it
	# gets emitted after every _process call
