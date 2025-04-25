extends ItemList

var _worker_dict: UpgradeDict

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_worker_dict = WorkerUpgradeDict.create()
	_worker_dict_update(_worker_dict)

func _worker_dict_update(worker_dict: UpgradeDict) -> void:
	clear()
	var workers = worker_dict.get_upgrades()
	for key in workers.keys():
		var worker_description: UpgradeDescription = workers[key]
		worker_description._name
		var text: String = worker_description._name + ": " + worker_description.stringify_costs()
		add_item(text)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
