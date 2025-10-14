class_name RPSLabel extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var root: Node = get_parent().get_parent()
	var controller = root.get_node("RPSController")

	# wire up all three of the Rock, Paper, and Scissors nodes to this
	for nodename in ["Rock", "Paper", "Scissors"]:
		var node = root.get_node(nodename)

		if node.has_signal(RPSButton.RPS_CHOSEN_NAME):
			node.rps_chosen.connect(_on_rps_button_rps_chosen)
			node.rps_chosen.connect(controller._on_rps_chosen)

# Hook up to signal rps_chosen (RPS_CHOSEN_NAME) in rps_button.gd
func _on_rps_button_rps_chosen(rps: String) -> void:
	self.text = rps
