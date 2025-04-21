extends Node2D

signal corruption_changed(new_corruption)
const CORRUPTION_CHANGED_NAME = "corruption_changed"

var _total_corruption = 0.0

var _corruption_click_value = 1.0
var _corruption_per_second = 1.0

func update_corruption_rate() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_total_corruption += (_corruption_per_second * delta)
	emit_signal(CORRUPTION_CHANGED_NAME, _total_corruption)


func _on_corruption_button_pressed() -> void:
	_total_corruption += _corruption_click_value
	# NOTE: we do not emit the CORRUPTION_CHANGED_NAME signal here because it
	# gets emitted after every _process call
