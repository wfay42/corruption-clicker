extends Node

signal cash_changed(cash_value)
const CASH_CHANGED_NAME: String = "cash_changed"

signal timer_started(timer)
const TIMER_STARTED_NAME: String = "timer_started"

const PLAYER_NAME: String = "Player"
const COMPUTER_NAME: String = "Computer"
const TIE_NAME: String = "Tie"

var __timer: Timer
var __timer_duration: float

var __computerChoiceNode: Node
var __resultNode: Node
var __rps_nodes: Array[Node]
var __countdownLabel: Label

var __cashValueNode: Label

var __playerChoice: Choices.RPSChoice

var __computerRng: RandomNumberGenerator
var __cashManager: CashManager

var __upgrades: Upgrades
var __upgradeList: ItemList

func _ready() -> void:
	self.__timer_duration = 0.1
	self.__cashManager = CashManager.new()

	self.__timer = Timer.new()
	__timer.one_shot = true
	__timer.timeout.connect(_on_timer_timeout)

	# __timer must be added to the tree before it can be started
	self.add_child(__timer)

	self.__computerRng = RandomNumberGenerator.new()
	self.__computerRng.randomize()

	var countdownNode = self.get_node("Countdown")
	self.__computerChoiceNode = countdownNode.get_node("TheirInput")
	self.__resultNode = countdownNode.get_node("Result")

	self.__rps_nodes = _get_rps_nodes(self )

	_connect_children(__rps_nodes)

	self.__countdownLabel = countdownNode.get_node("CountdownValue")
	timer_started.connect(self.__countdownLabel._on_timer_started)

	self.__cashValueNode = self.get_node("Cash").get_node("CashValue")
	cash_changed.connect(self.__cashValueNode._on_cash_changed)

	self.__upgrades = Upgrades.new()
	self.__upgradeList = self.get_node("Upgrades").get_node("UpgradeList")
	self.__upgradeList.setup(self.__upgrades, CashManagerView.new(self.__cashManager))
	self.__upgradeList.refreshList()

	self.__upgrades.upgradePurchased.connect(self.__cashManager.onUpgradePurchased)

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
	for rps_nodename in Choices.RPS_CHOICE_NAMES_LIST:
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
	timer_started.emit(__timer)
	var playerChoiceStr: String = value.strip_edges()
	self.__playerChoice = Choices.get_choice_value(playerChoiceStr)
	self.__resultNode.text = ""
	self.__computerChoiceNode.text = ""

func _on_timer_timeout() -> void:
	"""
	Called when countdown timer finishes
	"""
	disable_rps_buttons(false)
	var computerChoice: Choices.RPSChoice = _decide_computer_choice()
	var computerChoiceStr: String = Choices.get_choice_name(computerChoice)
	__computerChoiceNode.text = computerChoiceStr
	var winner: String = _determine_winner(self.__playerChoice, computerChoice)
	self.__resultNode.text = winner
	resolve_winning_outcome(winner)


func disable_rps_buttons(disabled: bool) -> void:
	"""
	Enables or disables all RPS buttons
	"""
	for rps_node in __rps_nodes:
		if rps_node is RPSButton:
			rps_node.disabled = disabled

func _decide_computer_choice() -> Choices.RPSChoice:
	var choice: int = self.__computerRng.randi_range(0, 2)
	var retval = Choices.RPS_CHOICE_VALUES_LIST[choice]
	print("Computer choice: %d" % [choice])
	return retval

func _determine_winner(player_choice: Choices.RPSChoice, computer_choice: Choices.RPSChoice) -> String:
	var winner: int = Choices.determine_winner(player_choice, computer_choice)
	if winner == 0:
		return TIE_NAME
	elif winner < 0:
		return PLAYER_NAME
	else:
		return COMPUTER_NAME

func resolve_winning_outcome(winner: String) -> void:
	"""
	Updates the cash value based on the winner of the RPS game
	"""
	match winner:
		PLAYER_NAME:
			add_cash()

	cash_changed.emit(self.__cashManager.get_cash())


func add_cash() -> void:
	self.__cashManager.increment()
