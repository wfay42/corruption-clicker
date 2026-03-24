class_name RPSButton extends Button

signal rps_chosen(text)
const RPS_CHOSEN_NAME: String = "rps_chosen"

func _ready() -> void:
	pass


func _on_pressed() -> void:
	# Essentially uses the unique name of the node, so they must remain the names listed in Constants.gd
	var rps_type: String = self.name.strip_edges()
	rps_chosen.emit(rps_type)
