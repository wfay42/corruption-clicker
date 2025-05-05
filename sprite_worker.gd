extends Sprite2D

var _updateSpriteFunc: Callable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_updateSpriteFunc = _update_sprites
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_sprint_noop(unused: float) -> bool:
	return false

func _update_sprites(new_corruption: float) -> bool:
	if new_corruption >= 15:
		texture = preload("res://img/char-arisa-02.png")
		return true
	return false

func _on__hidden_value_controller_corruption_changed(new_corruption: Variant) -> void:
	var retVal = _updateSpriteFunc.call(new_corruption)
	if retVal:
		_updateSpriteFunc = _update_sprint_noop
