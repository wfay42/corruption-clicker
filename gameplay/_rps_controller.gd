extends Node

var timer: Timer
var timer_duration: float

var computerChoice: Node

func _ready() -> void:
	timer_duration = 3.0

	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

	# timer must be added to the tree before it can be started
	self.add_child(timer)

	# TODO: Need to figure out how to connect this to the computer's choice,
	# or solve this by emitting a signal and hooking that up elsewhere
	computerChoice = self.get_node("Countdown").get_node("YourInput")

	_connect_children()

func _connect_children() -> void:
	var controller = self
	var countdown = self.get_node("Countdown")
	var yourInput = countdown.get_node("YourInput")

	for rps_nodename in ["Rock", "Paper", "Scissors"]:
		var rps_node = self.get_node(rps_nodename)

		if rps_node.has_signal(RPSButton.RPS_CHOSEN_NAME):
			rps_node.rps_chosen.connect(yourInput._on_rps_button_rps_chosen)
			rps_node.rps_chosen.connect(controller._on_rps_chosen)

func _process(delta: float) -> void:
	pass

func _on_rps_chosen(value: String) -> void:
	if timer.is_stopped():
		timer.start(timer_duration)

func _on_timer_timeout() -> void:
	print("Timer timeout")
