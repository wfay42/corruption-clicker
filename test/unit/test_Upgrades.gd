extends GutTest

func test_ALL_UPGRADES_has_correct_format():
	"""
	Asserts that all the required fields are present in ALL_UPGRADES and that they are of the correct type.
	"""
	for upgradeId in Upgrades.ALL_UPGRADES.keys():
		var upgrade = Upgrades.ALL_UPGRADES[upgradeId]
		assert_true(upgrade.has(Upgrades.ID_KEY), "Upgrade is missing 'id' field.")
		assert_true(upgrade.has(Upgrades.NAME_KEY), "Upgrade is missing 'name' field.")
		assert_true(upgrade.has(Upgrades.DESCRIPTION_KEY), "Upgrade is missing 'description' field.")
		assert_true(upgrade.has(Upgrades.COST_KEY), "Upgrade is missing 'cost' field.")