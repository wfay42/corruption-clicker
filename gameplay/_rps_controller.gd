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
	# computerChoice = self.get_node("Countdown").get_node("YourInput")

func _process(delta: float) -> void:
	pass

func _on_rps_chosen(value: String) -> void:
	if timer.is_stopped():
		timer.start(timer_duration)

func _on_timer_timeout() -> void:
	print("Timer timeout")
