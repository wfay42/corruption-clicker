class_name RPSLabel extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Hook up to signal rps_chosen (RPS_CHOSEN_NAME) in rps_button.gd
func _on_rps_button_rps_chosen(rps: String) -> void:
	self.text = rps
