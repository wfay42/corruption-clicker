extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# self.connect(RPSButton.RPS_CHOSEN_NAME, _on_rps_button_rps_chosen)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Hook up to signal rps_chosen (RPS_CHOSEN_NAME) in rps_button.gd
func _on_rps_button_rps_chosen(rps: String) -> void:
	self.text = rps
