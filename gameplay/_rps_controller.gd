extends Node

const PLAYER_NAME: String = "Player"
const COMPUTER_NAME: String = "Computer"

var __timer: Timer
var __timer_duration: float

var __computerChoiceNode: Node
var __resultNode: Node
var __rps_nodes: Array[Node]

var __cashValueNode: Label

var __playerChoice: String

var __computerRng: RandomNumberGenerator
var __cash_value: int

func _ready() -> void:
	self.__timer_duration = 3.0
	self.__cash_value = 0

	self.__timer = Timer.new()
	__timer.one_shot = true
	__timer.timeout.connect(_on_timer_timeout)

	# __timer must be added to the tree before it can be started
	self.add_child(__timer)

	self.__computerRng = RandomNumberGenerator.new()
	self.__computerRng.randomize()

	self.__computerChoiceNode = self.get_node("Countdown").get_node("TheirInput")
	self.__resultNode = self.get_node("Countdown").get_node("Result")

	self.__rps_nodes = _get_rps_nodes(self)

	__cashValueNode = self.get_node("Cash").get_node("CashValue")

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
	self.__resultNode.text = ""
	self.__computerChoiceNode.text = ""

func _on_timer_timeout() -> void:
	"""
	Called when countdown timer finishes
	"""
	disable_rps_buttons(false)
	var computerChoice = _decide_computer_choice()
	__computerChoiceNode.text = computerChoice
	var winner = _determine_winner(self.__playerChoice, computerChoice)
	self.__resultNode.text = winner
	resolve_winning_outcome(winner)



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
		return PLAYER_NAME
	else:
		return COMPUTER_NAME

func resolve_winning_outcome(winner: String) -> void:
	"""
	Updates the cash value based on the winner of the RPS game
	"""
	match winner:
		PLAYER_NAME:
			add_cash(10)
		COMPUTER_NAME:
			add_cash(-10)

	# TODO: update CashValue node to receive a signal when cash changes
	self.__cashValueNode.text = str(self.__cash_value)


func add_cash(amount: int) -> void:
	self.__cash_value += amount
