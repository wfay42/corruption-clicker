class_name Upgrades extends Object

const CASH_PLUS_KEY: String = "cash+"
const ALL_UPGRADES: Dictionary[String, Dictionary] = {
    "cash001": {
        "name": "Cash Prize Lv. 1",
        "description": "Increase cash prize by 1",
        "cost": 10,
        "cash+": 1,
        "dependencies": []
    },
    "cash002": {
        "name": "Cash Prize Lv. 2",
        "description": "Increase cash prize by 5",
        "cost": 200,
        "cash+": 5,
        "dependencies": []
    },
}

var _ownedUpgradeIds: Array[String]

func _init() -> void:
    _ownedUpgradeIds = []

func hasUpgrade(upgradeId: String) -> bool:
    return upgradeId in _ownedUpgradeIds

func getOwnedCashPlusUpgradeValue() -> int:
    """ Sums up the cash+ values of all owned upgrades and returns the total
     Returns 0 if no cash+ upgrades are owned
    """
    var totalCashPlus: int = 0
    for upgradeId in _ownedUpgradeIds:
        var upgradeData = ALL_UPGRADES.get(upgradeId, null)
        if upgradeData != null and upgradeData.has(CASH_PLUS_KEY):
            totalCashPlus += upgradeData[CASH_PLUS_KEY]
    return totalCashPlus

func getAllAvailableUpgrades() -> Array[Dictionary]:
    """ Returns a list of all upgrade data dictionaries for upgrades that are currently available for purchase
     (i.e. not owned and dependencies met)
    """
    var availableUpgrades: Array[Dictionary] = []
    for upgradeId in ALL_UPGRADES.keys():
        if isUpgradeAvailable(upgradeId):
            availableUpgrades.append(ALL_UPGRADES[upgradeId])
    return availableUpgrades

func isUpgradeAvailable(upgradeId: String) -> bool:
    """ Returns true if upgrade is not owned and all dependencies are met """
    if upgradeId in _ownedUpgradeIds:
        return false

    var upgradeData = ALL_UPGRADES.get(upgradeId, null)
    if upgradeData == null:
        return false

    var dependencies = upgradeData.get("dependencies", [])
    for dependencyId in dependencies:
        if dependencyId not in _ownedUpgradeIds:
            return false

    return true