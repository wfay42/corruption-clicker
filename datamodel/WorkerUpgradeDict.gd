class_name WorkerUpgradeDict extends Object

static func create() -> UpgradeDict:
	var ud = UpgradeDict.new()
	ud.add("Factory Worker",
		"Someone to help you work the factory.",
		[Cost.new(1, CurrencyTracker.DOLLAR)],
		CurrencyRate.new(1.0, 0.0))
	return ud
