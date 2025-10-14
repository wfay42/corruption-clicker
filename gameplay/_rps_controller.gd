extends Node

var timer: Timer

func _ready() -> void:
    timer = Timer.new()
    timer.one_shot = true
    timer.timeout.connect(_on_timer_timeout)
    print("Is timer stopped? %s" % timer.is_stopped())

    # timer must be added to the tree before it can be started
    self.add_child(timer)

func _process(delta: float) -> void:
    pass

func _on_rps_chosen(value: String) -> void:
    if timer.is_stopped():
        timer.start(3.0)

func _on_timer_timeout() -> void:
    print("Timer timeout")