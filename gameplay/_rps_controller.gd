extends Node

var __timer: Timer
var __timer_duration: float

var __computerChoice: Node
var __rps_nodes: Array[Node]

func _ready() -> void:
	self.__timer_duration = 3.0

	self.__timer = Timer.new()
	__timer.one_shot = true
	__timer.timeout.connect(_on_timer_timeout)

	# __timer must be added to the tree before it can be started
	self.add_child(__timer)

	# TODO: Need to figure out how to connect this to the computer's choice,
	# or solve this by emitting a signal and hooking that up elsewhere
	self.__computerChoice = self.get_node("Countdown").get_node("YourInput")

	self.__rps_nodes = _get_rps_nodes()

	_connect_children(__rps_nodes)

func _connect_children(rps_nodes: Array[Node]) -> void:
	var controller = self
	var countdown = self.get_node("Countdown")
	var yourInput = countdown.get_node("YourInput")

	for rps_node in rps_nodes:
		if rps_node.has_signal(RPSButton.RPS_CHOSEN_NAME):
			rps_node.rps_chosen.connect(yourInput._on_rps_button_rps_chosen)
			rps_node.rps_chosen.connect(controller._on_rps_chosen)

func _get_rps_nodes() -> Array[Node]:
	var rps_nodes: Array[Node] = []
	for rps_nodename in ["Rock", "Paper", "Scissors"]:
		rps_nodes.append(self.get_node(rps_nodename))

	return rps_nodes

func _process(_delta: float) -> void:
	pass

func _on_rps_chosen(_value: String) -> void:
	if __timer.is_stopped():
		__timer.start(__timer_duration)
		disable_rps_buttons(true)

func _on_timer_timeout() -> void:
	disable_rps_buttons(false)

func disable_rps_buttons(disabled: bool) -> void:
	for rps_node in __rps_nodes:
		if rps_node is RPSButton:
			rps_node.disabled = disabled
