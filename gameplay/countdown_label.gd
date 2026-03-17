class_name CountdownLabel extends Label

var _timer: Timer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if _timer != null and !_timer.is_stopped():
		self.text = "%.1f" % _timer.time_left

func _on_timer_started(timer: Timer) -> void:
	self._timer = timer
