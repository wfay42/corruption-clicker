class_name Upgrades extends Object

const CASH_PLUS_KEY: String = "cash+"
const COST_KEY: String = "cost"
const DEPENDENCIES_KEY: String = "dependencies"
const DESCRIPTION_KEY: String = "description"
const ID_KEY: String = "id"
const NAME_KEY: String = "name"

"""
Future ideas:
    - Kind of unfortunate that I have "id" in two places. Would love to consolidate that
"""
const ALL_UPGRADES: Dictionary[String, Dictionary] = {
    "cash001": {
        "id": "cash001",
        "name": "Cash Prize Lv. 1",
        "description": "Increase cash reward by 1 per victory",
        "cost": 3,
        "cash+": 1,
        "dependencies": []
    },
    "cash002": {
        "id": "cash002",
        "name": "Cash Prize Lv. 2",
        "description": "Increase cash reward by 5 per victory",
        "cost": 200,
        "cash+": 5,
        "dependencies": ["cash001"]
    },
}

signal upgradePurchased(upgradeId, Upgrades)
const UPGRADE_PURCHASED_NAME: String = "upgradePurchased"

var _ownedUpgradeIds: Array[String]
var _upgradesMutex: Mutex

func _init() -> void:
    _ownedUpgradeIds = []
    _upgradesMutex = Mutex.new()

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
    """ Returns true if upgrade is not owned and all dependencies are met. Does NOT check cost """
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

func tryPurchase(upgradeId: String, currentCash: float) -> bool:
    """ Attempts to purchase the upgrade with the given ID if the player has enough cash
     Returns true if purchase is successful, false otherwise (e.g. not available or insufficient funds)
     Note: This function does not handle deducting cash or other side effects, it only updates owned upgrades
    """
    var upgradeData = ALL_UPGRADES.get(upgradeId, null)
    if not isUpgradeAvailable(upgradeId):
        return false

    var cost = upgradeData.get(COST_KEY, null)
    if cost == null:
        return false
    if currentCash < cost:
        return false

    _upgradesMutex.lock()
    _ownedUpgradeIds.append(upgradeId)
    _upgradesMutex.unlock()

    upgradePurchased.emit(upgradeId, self )
    return true