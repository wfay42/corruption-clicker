extends Node2D

signal corruption_changed(new_corruption)

var _total_corruption = 0.0

# TODO: make this settable/changeable
var _corruption_value = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_corruption_button_pressed() -> void:
	_total_corruption += _corruption_value
	emit_signal("corruption_changed", _total_corruption)
