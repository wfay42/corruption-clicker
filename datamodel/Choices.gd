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
    RPSChoice.SCISSORS: Constants.SCISSORS
}

# Map string names to Choice enums
const RPS_CHOICE_VALUES: Dictionary[String, RPSChoice] = {
    Constants.ROCK: RPSChoice.ROCK,
    Constants.PAPER: RPSChoice.PAPER,
    Constants.SCISSORS: RPSChoice.SCISSORS
}

# Array of all Choice string names
const RPS_CHOICE_VALUES_LIST: Array[RPSChoice] = [RPSChoice.ROCK, RPSChoice.PAPER, RPSChoice.SCISSORS]
const RPS_CHOICE_NAMES_LIST: Array[String] = [Constants.ROCK, Constants.PAPER, Constants.SCISSORS]

static func get_choice_name(choice: RPSChoice) -> String:
    return RPS_CHOICE_NAMES.get(choice, "")

static func get_choice_value(name: String) -> RPSChoice:
    return RPS_CHOICE_VALUES.get(name, -1)

static func determine_winner(player1: RPSChoice, player2: RPSChoice) -> int:
    """"Determines the winner of a rock-paper-scissors game
    Returns:
        0 if it's a tie
        -1 if player 1 wins
        1 if player 2 wins
    """
    if player1 == player2:
        return 0
    elif (player1 == RPSChoice.ROCK and player2 == RPSChoice.SCISSORS) or \
         (player1 == RPSChoice.PAPER and player2 == RPSChoice.ROCK) or \
         (player1 == RPSChoice.SCISSORS and player2 == RPSChoice.PAPER):
        return -1
    else:
        return 1