extends Sprite2D

var _updateSpriteFunc: Callable

var next_level = 1

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
	if new_corruption >= next_level and get_meta("second_phase") == false:
		#texture = preload("res://img/char-arisa-02.png")
		var offset: Vector2 = Vector2.DOWN * 50
		global_translate(offset)
		get_parent().global_translate(-offset)
		next_level += 1
		return true
	return false

func _on__hidden_value_controller_corruption_changed(new_corruption: Variant) -> void:
	_updateSpriteFunc.call(new_corruption)
	#if retVal:
		#_updateSpriteFunc = _update_sprint_noop
