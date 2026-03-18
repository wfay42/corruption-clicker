class_name RPSButton extends Button

signal rps_chosen(text)
const RPS_CHOSEN_NAME: String = "rps_chosen"

func _ready() -> void:
	pass


func _on_pressed() -> void:
	var rps_type: String = self.text
	rps_chosen.emit(rps_type)
