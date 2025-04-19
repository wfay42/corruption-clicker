extends ItemList

var _upgrades = {
	"Increase Corruption production": 15	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# start with the list as hidden unless it has something in it
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_item(upgrade_name: String) -> void:
	add_item(upgrade_name)
	show()

func _on__hidden_value_controller_corruption_changed(new_corruption: Variant) -> void:
	for upgrade_name in _upgrades.keys():
		var upgrade_cost = _upgrades[upgrade_name]
		if upgrade_cost <= new_corruption:
			_add_item(upgrade_name)
			_upgrades.erase(upgrade_name)
