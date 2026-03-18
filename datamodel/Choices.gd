class_name Choices extends Object

enum RPSChoice {
    ROCK,
    PAPER,
    SCISSORS
}

# Map Choice enums to string names
const RPS_CHOICE_NAMES: Dictionary[RPSChoice, String] = {
    RPSChoice.ROCK: Constants.ROCK,
    RPSChoice.PAPER: Constants.PAPER,
    RPSChoice.SCISSORS: Constants.PAPER
}

# Map string names to Choice enums
const RPS_CHOICE_VALUES: Dictionary[String, RPSChoice] = {
    Constants.ROCK: RPSChoice.ROCK,
    Constants.PAPER: RPSChoice.PAPER,
    Constants.SCISSORS: RPSChoice.SCISSORS
}

# Array of all Choice string names
const RPS_CHOICE_NAMES_LIST: Array[String] = [Constants.ROCK, Constants.PAPER, Constants.SCISSORS]

static func get_choice_name(choice: RPSChoice) -> String:
    return RPS_CHOICE_NAMES.get(choice, "")

static func get_choice_value(name: String) -> RPSChoice:
    return RPS_CHOICE_VALUES.get(name, -1)