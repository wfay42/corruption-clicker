class_name RPSButton extends Button

signal rps_chosen(text)
const RPS_CHOSEN_NAME: String = "rps_chosen"

func _ready() -> void:
	## TODO: should flip this relationship around so YourInput is what says to connect to this signal
	var yourInput: Node = get_parent().get_node("Countdown").get_node("YourInput")
	rps_chosen.connect(yourInput._on_rps_button_rps_chosen)


func _on_pressed() -> void:
	# var rps_type = self.text
	var rps_type = "rok"
	emit_signal(RPS_CHOSEN_NAME, rps_type)
