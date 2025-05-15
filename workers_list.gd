extends ItemList

var _worker_dict: UpgradeDict
var _remaining_worker_dict: UpgradeDict

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_worker_dict = UpgradeDict.new()
	_remaining_worker_dict = WorkerUpgradeDict.create()
	#_worker_dict_update(_worker_dict)

func _worker_dict_update(worker_dict: UpgradeDict) -> void:
	clear()
	var workers = worker_dict.get_upgrades()
	for key in workers.keys():
		var worker_description: UpgradeDescription = workers[key]
		var text: String = worker_description._name + ": " + worker_description.stringify_costs()
		add_item(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on__hidden_value_controller_currency_changed(new_currency_values: Variant) -> void:
	var currency_values: Dictionary[CurrencyTracker.CurrencyId, float] = new_currency_values
	
	var workers = _remaining_worker_dict.get_upgrades()
	for key in workers.keys():
		var worker_description: UpgradeDescription = workers[key]
		for cost: Cost in worker_description._costs:
			var currency_id: CurrencyTracker.CurrencyId = cost._currency._id
			var currency_value = currency_values[currency_id]
			if currency_value >= cost._amount:
				_worker_dict.add_upgrade(worker_description)
				_remaining_worker_dict.erase(worker_description._id)
	_worker_dict_update(_worker_dict)
