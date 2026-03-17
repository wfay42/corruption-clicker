class_name CashLabel extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Hook up to signal rps_chosen (RPS_CHOSEN_NAME) in rps_button.gd
func _on_cash_changed(cash_value: int) -> void:
	self.text = str(cash_value)
