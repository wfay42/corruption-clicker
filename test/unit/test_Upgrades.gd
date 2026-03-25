extends GutTest

func create_type_failure_message(upgradeId: String, fieldName: String, expectedType: String, upgrade: Dictionary) -> String:
	var actualType = get_type_string(upgrade, fieldName)
	return "Upgrade '%s' has field '%s' of type %s but expected type is %s." % [upgradeId, fieldName, actualType, expectedType]

func get_type_string(upgrade: Dictionary, fieldName: String) -> String:
	return type_string(typeof(upgrade[fieldName]))

func test_ALL_UPGRADES_has_correct_format():
	"""
	Asserts that all the required fields are present in ALL_UPGRADES and that they are of the correct type.
	"""
	for upgradeId in Upgrades.ALL_UPGRADES.keys():
		var upgrade = Upgrades.ALL_UPGRADES[upgradeId]
		assert_true(upgrade.has(Upgrades.ID_KEY), "Upgrade is missing 'id' field.")
		assert_true(upgrade[Upgrades.ID_KEY] is String, \
			create_type_failure_message(upgradeId, Upgrades.ID_KEY, "String", upgrade))

		assert_true(upgrade.has(Upgrades.NAME_KEY), "Upgrade is missing 'name' field.")
		assert_true(upgrade[Upgrades.NAME_KEY] is String, \
			create_type_failure_message(upgradeId, Upgrades.NAME_KEY, "String", upgrade))

		assert_true(upgrade.has(Upgrades.DESCRIPTION_KEY), "Upgrade is missing 'description' field.")
		assert_true(upgrade[Upgrades.DESCRIPTION_KEY] is String, \
			create_type_failure_message(upgradeId, Upgrades.DESCRIPTION_KEY, "String", upgrade))

		assert_true(upgrade.has(Upgrades.COST_KEY), "Upgrade is missing 'cost' field.")
		assert_true(upgrade[Upgrades.COST_KEY] is int, \
			create_type_failure_message(upgradeId, Upgrades.COST_KEY, "int", upgrade))

		assert_true(upgrade.has(Upgrades.DEPENDENCIES_KEY), "Upgrade is missing 'dependencies' field.")
		assert_true(upgrade[Upgrades.DEPENDENCIES_KEY] is Array, \
			create_type_failure_message(upgradeId, Upgrades.DEPENDENCIES_KEY, "Array", upgrade))