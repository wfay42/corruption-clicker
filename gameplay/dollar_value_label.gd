extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on__hidden_value_controller_dollars_changed(new_dollars: float) -> void:
	self.text = str(int(new_dollars))
