extends ItemList

"""
class UpgradeDescription
	int id
	String name
	float cost
	func whatItDoes - necessitates a way to run all of these functions at runtime

List of all upgrades
	Immutable Dictionary
	Maps numerical IDs to Upgrade object
"""

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

func _add_item(upgrade_name: String, metadata: Dictionary) -> void:
	var idx = add_item(upgrade_name)
	set_item_metadata(idx, metadata)
	if not visible:
		show()

func _on__hidden_value_controller_corruption_changed(new_corruption: Variant) -> void:
	for upgrade_name in _upgrades.keys():
		var upgrade_cost = _upgrades[upgrade_name]
		if upgrade_cost <= new_corruption:
			var metadata = {"cost": upgrade_cost}
			_add_item(upgrade_name, metadata)
			_upgrades.erase(upgrade_name)


func _on_item_activated(index: int) -> void:
	var metadata = get_item_metadata(index)
	var cost = metadata["cost"]
	remove_item(index)
