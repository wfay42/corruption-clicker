extends Node

var __timer: Timer
var __timer_duration: float

var __computerChoice: Node
var __result: Node
var __playerChoice: String
var __rps_nodes: Array[Node]

var __computerRng: RandomNumberGenerator

func _ready() -> void:
	self.__timer_duration = 3.0

	self.__timer = Timer.new()
	__timer.one_shot = true
	__timer.timeout.connect(_on_timer_timeout)

	# __timer must be added to the tree before it can be started
	self.add_child(__timer)

	self.__computerRng = RandomNumberGenerator.new()
	self.__computerRng.randomize()

	self.__computerChoice = self.get_node("Countdown").get_node("TheirInput")
	self.__result = self.get_node("Countdown").get_node("Result")

	self.__rps_nodes = _get_rps_nodes(self)

	_connect_children(__rps_nodes)

func _connect_children(rps_nodes: Array[Node]) -> void:
	var controller = self
	var countdown = self.get_node("Countdown")
	var yourInput = countdown.get_node("YourInput")

	for rps_node in rps_nodes:
		if rps_node.has_signal(RPSButton.RPS_CHOSEN_NAME):
			rps_node.rps_chosen.connect(yourInput._on_rps_button_rps_chosen)
			rps_node.rps_chosen.connect(controller._on_rps_chosen)

func _get_rps_nodes(root: Node) -> Array[Node]:
	var rps_nodes: Array[Node] = []
	for rps_nodename in ["Rock", "Paper", "Scissors"]:
		rps_nodes.append(root.get_node(rps_nodename))

	return rps_nodes

func _process(_delta: float) -> void:
	pass

func _on_rps_chosen(value: String) -> void:
	""""
	Called when player chooses Rock, Paper, or Scissors
	"""
	if not __timer.is_stopped():
		return

	disable_rps_buttons(true)
	__timer.start(__timer_duration)
	self.__playerChoice = value
	self.__result.text = ""
	self.__computerChoice.text = ""

func _on_timer_timeout() -> void:
	"""
	Called when countdown timer finishes
	"""
	disable_rps_buttons(false)
	var computerChoice = _decide_computer_choice()
	__computerChoice.text = computerChoice
	var winner = _determine_winner(self.__playerChoice, computerChoice)
	self.__result.text = winner

func disable_rps_buttons(disabled: bool) -> void:
	"""
	Enables or disables all RPS buttons
	"""
	for rps_node in __rps_nodes:
		if rps_node is RPSButton:
			rps_node.disabled = disabled

func _decide_computer_choice() -> String:
	var choice = self.__computerRng.randi_range(1, 3)
	print("Choice: %d" % choice)
	match choice:
		1:
			return "Rock"
		2:
			return "Paper"
		_:
			return "Scissors"

func _determine_winner(player_choice: String, computer_choice: String) -> String:
	if player_choice == computer_choice:
		return "Tie"
	elif (player_choice == "Rock" and computer_choice == "Scissors") or \
			(player_choice == "Paper" and computer_choice == "Rock") or \
			(player_choice == "Scissors" and computer_choice == "Paper"):
		return "Player"
	else:
		return "Computer"
